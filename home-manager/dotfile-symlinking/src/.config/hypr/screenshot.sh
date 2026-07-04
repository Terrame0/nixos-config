# -- behaviour of shift with selection rectangles is broken
# windows_json=$(hyprctl clients -j)
# current_ws=$(hyprctl activeworkspace -j | jq -r '.id')
# rects=$(hyprctl clients -j | jq -r \
#     ".[] | select(.workspace.id == $current_ws) | \"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])\"")
# echo $rects
grim -g "$(slurp -b 1d1f21b3 -w 1 -c b9ca4a)" - | wl-copy

