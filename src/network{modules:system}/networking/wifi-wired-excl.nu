def main [iface: string, action: string] {
  if $action not-in ["up" "down"] { return }
  let wired = ^nmcli -t -f TYPE,STATE device status 
    | complete | get stdout | lines 
    | any {|line| $line == "ethernet:connected" }
  if $wired {^nmcli radio wifi off | complete | ignore} 
  else {^nmcli radio wifi on | complete | ignore}
}