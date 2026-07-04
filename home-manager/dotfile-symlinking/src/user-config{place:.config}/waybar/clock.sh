sec=$(date +%S)
day=$(date +"%d")
mon=$(date +"%b")
mon="${mon^}"

colon="<span color='#969896'>:</span>"
sep="<span color='#c397d8'> == </span>"
point="<span color='#969896'>·</span>"

if (( 10#$sec % 2 == 0 )); then
    hm=$(date +"%H$colon%M")
else
    hm=$(date +"%H %M")
fi

echo "$hm$sep$day$point$mon"