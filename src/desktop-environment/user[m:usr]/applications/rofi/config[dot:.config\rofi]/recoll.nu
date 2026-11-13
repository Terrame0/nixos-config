#!/usr/bin/env nu

def pango_escape [s: string] { $s | str replace --all '&' '&amp;' | str replace --all '<' '&lt;' | str replace --all '>' '&gt;' }

def wrap_data [key:string,value:any] { return $"\u{0}($key)\u{1f}($value)" }

def wrap_span [props:record,contents:string] { $props | items { |k,v| $"($k)='($v)'" } | str join " " | $"<span ($in)>(pango_escape $contents)</span>" }

def get_query [query:string] {
    let fields = [ 
        "filename" 
        "abstract" 
        "relevancyrating" 
        "mtype" 
        "url"
    ]
    let recoll_output = ^recollq -F ($fields | str join " ") $query | complete | $in.stdout
    return ($recoll_output | lines | skip 2 | each { |line| 
        let values = $line | str trim | split row " " 
        let decoded = $values | each { |value| $value | decode base64 | decode utf-8}
        let sanitized = $decoded | str trim | str replace --all --regex '\s+' ' '
        return ($fields | zip $sanitized | into record)
    })
}

def main [input?:string] {
    let retv = ($env.ROFI_RETV? | default "0")
    let info = ($env.ROFI_INFO? | default "")
    print (wrap_data markup-rows true)
    print (wrap_data prompt recoll)
    print (wrap_data use-hot-keys true)
    if $retv == "0" {
    } else if $retv == "1" {
        ^setsid -f xdg-open $info out+err> /dev/null
        exit 0
    } else if $retv == "2" {
        let results = get_query $input
        if ($results | length) == 0 {
            print (wrap_span {style: "italic"} "...search result empty...")
        } else {
            let message =  " 'enter' to open, 'ctrl + enter' to run a new query"
            print (wrap_data message (wrap_span {weight: "thin",style: "italic", size: "small"} $message))
            for result in $results {
                let title = wrap_span {weight: bold} $result.filename
                let abstract = wrap_span {weight: "thin",style: "italic", size: "small"} $result.abstract
                let info = wrap_data info $result.url
                print $"($title) ($abstract) ($info)"
            }
        }
    }
}