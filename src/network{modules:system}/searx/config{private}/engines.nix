{sundry, ...}: {
  engines =
    map
    (list:
      sundry.list.zip-to-attrs
      ["disabled" "name" "engine" "weight" "base_url"]
      ([false] ++ list))
    [
      ["wikipedia" "wikipedia" 2.0]
      ["google_us" "google" 1.5 "https://www.google.com"]
      ["google_uk" "google" 1.5 "https://www.google.co.uk"]
      ["brave" "brave" 1.0]
      ["bing_com" "bing" 1.0 "https://www.bing.com"]
      ["bing_cn" "bing" 1.0 "https://cn.bing.com"]
      ["yahoo" "yahoo" 0.7]
      ["dogpile" "dogpile" 0.7]

      ["github" "github" 1.2]
      ["stackoverflow" "stackoverflow" 1.0]

      ["openverse" "openverse" 1.0]
      ["unsplash" "unsplash" 1.0]

      ["wikidata" "wikidata" 1.5]
      ["arxiv" "arxiv" 1.0]
    ];
}
