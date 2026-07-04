if ! SKELETON_CHECK="$(sing-box check -c "$SKELETON" 2>&1)"; then
  echo "FATAL: the config skeleton itself is invalid — this is a config bug, not a network failure" >&2
  echo "$SKELETON_CHECK" >&2
  exit 1
fi

DO_UPDATE=false
if curl -sS \
  --connect-timeout 15 --max-time 40 \
  -H "x-hwid: $(cat "$CREDENTIALS_DIRECTORY/hwid")" \
  -H "x-device-os: Linux" \
  -H "x-ver-os: 1.0.0" \
  -H "x-device-model: Computer" \
  -A "singbox" \
  "$(cat "$CREDENTIALS_DIRECTORY/sub-url")" \
  -o "$RESPONSE_FILE";
then
  TMP="$(mktemp)"
  if jq --slurpfile response "$RESPONSE_FILE" -f "$NODE_FILTER" "$SKELETON" > "$TMP";
  then
    if CHECK_OUT="$(sing-box check -c "$TMP" 2>&1)"; then
      mv "$TMP" "$STORED_CONFIG"
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
rm -f "$RESPONSE_FILE"
if [ "$DO_UPDATE" = true ]; then
  cp "$STORED_CONFIG" "$RUNTIME_CONFIG"
elif [ -f "$STORED_CONFIG" ]; then
  echo "INFO: using the last valid configuration" >&2
  cp "$STORED_CONFIG" "$RUNTIME_CONFIG"
else
  echo "FATAL: no valid configuration found" >&2
  exit 1
fi
