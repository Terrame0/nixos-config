sec=$(date +%S)
day=$(date +"%d")
mon=$(date +"%b")
mon="${mon^}"

if (( 10#$sec % 2 == 0 )); then
    hm=$(date +"%H:%M")
else
    hm=$(date +"%H %M")
fi

echo "$hm === $day·$mon"