for card in (glob /sys/class/sound/card[0-9]* | sort) {
  let id_file = $"($card)/id"
  if not ($id_file | path exists) { continue }
  if (open $id_file | str trim) != "Headset" { continue }
  let n = ($card | path basename | str replace "card" "")
  for _ in 1..5 {
    let probe = (^amixer -c $n sset "G435 Wireless Gaming Headset Playback Switc" on | complete)
    if $probe.exit_code == 0 {
      ^amixer -c $n sset "G435 Wireless Gaming Headset Playback Volum" "100%" unmute | complete | ignore
      break
    }
    sleep 1sec
  }
}