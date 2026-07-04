# Injects a throwaway node into both selectors so the bare skeleton
# (whose auto-selector.outbounds is an empty placeholder) passes `sing-box check`.
# Lets the skeleton be validated for schema bugs without real subscription data.
({type: "direct", tag: "__skeleton_check_stub__"}) as $stub
| .outbounds = (.outbounds | map(
    if   .tag == "auto-selector" then .outbounds = ["__skeleton_check_stub__"]
    elif .tag == "proxy"         then .outbounds += ["__skeleton_check_stub__"]
    else . end)) + [$stub]
