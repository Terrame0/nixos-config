{
  pkgs,
  paths,
  skeleton,
  ...
}:
pkgs.writeShellApplication {
  name = "sing-box-updater";
  runtimeInputs = [pkgs.curl pkgs.jq pkgs.sing-box pkgs.coreutils];
  text = ''
    SKEL_STUB="$(mktemp)"
    jq '
        ({type: "direct", tag: "__skeleton_check_stub__"}) as $stub
        | .outbounds = (.outbounds | map(
            if   .tag == "auto-selector" then .outbounds = ["__skeleton_check_stub__"]
            elif .tag == "proxy"         then .outbounds += ["__skeleton_check_stub__"]
            else . end)) + [$stub]
      ' ${skeleton} > "$SKEL_STUB"
    if ! SKELETON_CHECK="$(sing-box check -c "$SKEL_STUB" 2>&1)"; then
      echo "FATAL: the config skeleton itself is invalid — this is a config bug, not a network failure." >&2
      echo "$SKELETON_CHECK" >&2
      rm -f "$SKEL_STUB"
      exit 1
    fi
    rm -f "$SKEL_STUB"

    DO_UPDATE=false
    if curl -sS \
      --connect-timeout 15 --max-time 40 \
      -H "x-hwid: $(cat "$CREDENTIALS_DIRECTORY/hwid")" \
      -H "x-device-os: Linux" \
      -H "x-ver-os: 1.0.0" \
      -H "x-device-model: Computer" \
      -A 'singbox' \
      "$(cat "$CREDENTIALS_DIRECTORY/sub-url")" \
      -o "${paths.response-file}";
    then
      TMP="$(mktemp)"
      if jq --slurpfile response "${paths.response-file}" '
          def is_node: .type == "vless" and .tls.reality.enabled? == true and .flow? == "xtls-rprx-vision";
          ($response[0].outbounds | map(select(is_node))) as $nodes
          | if ($nodes | length) < 1
            then error("0 nodes matched filter")
            else . end
          | ($nodes | map(.tag)) as $tags
          | .outbounds = (.outbounds | map(
              if   .tag == "auto-selector" then .outbounds = $tags
              elif .tag == "proxy"         then .outbounds += $tags
              else . end)) + $nodes
        ' ${skeleton} > "$TMP";
      then
        if CHECK_OUT="$(sing-box check -c "$TMP" 2>&1)"; then
          mv "$TMP" "${paths.stored-config}"
          DO_UPDATE=true
        else
          echo "WARN: the configuration didn't pass the check, falling back to the last valid configuration" >&2
          echo "$CHECK_OUT" >&2
          rm -f "$TMP"
        fi
      else 
        echo "WARN: merge failed (no matching nodes?), falling back" >&2
        rm -f "$TMP"
      fi
    else
      echo "WARN: subscription server not responding, falling back to the last valid configuration" >&2
    fi
    rm -f "${paths.response-file}"
    if [ "$DO_UPDATE" = true ]; then
      cp "${paths.stored-config}" "${paths.runtime-config}"
    elif [ -f "${paths.stored-config}" ]; then
      echo "INFO: using the last valid configuration" >&2
      cp "${paths.stored-config}" "${paths.runtime-config}"
    else
      echo "FATAL: no valid configuration found" >&2
      exit 1
    fi'';
}
