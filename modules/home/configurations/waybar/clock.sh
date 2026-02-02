sec=$(date +%S)
fmt="%H %M === %d %b"
(( 10#$sec % 2 == 0 )) && fmt="%H:%M === %d %b"
date +"$fmt"
