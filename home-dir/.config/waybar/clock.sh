sec=$(date +%S)
day=$(date +"%d")
mon=$(date +"%b")
mon="${mon^}"

colon="#[str|config.make-span {color = config.palette.comment;} ":"]"
sep="#[str|config.make-span {color = config.palette.purple;} "==="]"
point="#[str|config.make-span {color = config.palette.comment;} "·"]"

if (( 10#$sec % 2 == 0 )); then
    hm=$(date +"%H$colon%M")
else
    hm=$(date +"%H %M")
fi

echo "$hm $sep $day$point$mon"