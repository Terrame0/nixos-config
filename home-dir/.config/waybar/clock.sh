sec=$(date +%S)
day=$(date +"%d")
mon=$(date +"%b")
mon="${mon^}"

colon="#[str|config.make-span {color = config.style.palette.light-gray;} ":"]"
sep="#[str|config.make-span {color = config.style.palette.purple;} " == "]"
point="#[str|config.make-span {color = config.style.palette.light-gray;} "·"]"

if (( 10#$sec % 2 == 0 )); then
    hm=$(date +"%H$colon%M")
else
    hm=$(date +"%H %M")
fi

echo "$hm$sep$day$point$mon"