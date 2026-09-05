{...}: {
  force = true;
  default = "SearXNG";
  order = [
    "SearXNG"
    "google"
    "ddg"
    "yandex"
    "NixOS Packages"
    "NixOS Options"
    "Nix Flakes"
    "Home Manager Options"
  ];

  engines = {
    "SearXNG" = {
      urls = [
        {
          template = "http://localhost:8888/search?q={searchTerms}";
          params = [
            {
              name = "query";
              value = "{searchTerms}";
            }
          ];
        }
      ];
      #icon = "https://nixos.org/favicon.ico";
      #definedAliases = ["@np"];
    };
    "NixOS Packages" = {
      urls = [
        {
          template = "https://search.nixos.org/packages";
          params = [
            {
              name = "query";
              value = "{searchTerms}";
            }
          ];
        }
      ];
      icon = "https://nixos.org/favicon.ico";
      definedAliases = ["@np"];
    };

    "NixOS Options" = {
      urls = [
        {
          template = "https://search.nixos.org/options";
          params = [
            {
              name = "query";
              value = "{searchTerms}";
            }
          ];
        }
      ];
      icon = "https://nixos.org/favicon.ico";
      definedAliases = ["@no"];
    };

    "Nix Flakes" = {
      urls = [
        {
          template = "https://search.nixos.org/flakes";
          params = [
            {
              name = "q";
              value = "{searchTerms} flake.nix";
            }
          ];
        }
      ];
      icon = "https://nixos.org/favicon.ico";
      definedAliases = ["@nf"];
    };

    "Home Manager Options" = {
      urls = [
        {
          template = "https://home-manager-options.extranix.com/";
          params = [
            {
              name = "query";
              value = "{searchTerms}";
            }
          ];
        }
      ];
      icon = "https://nixos.org/favicon.ico";
      definedAliases = ["@hm"];
    };
  };
}
