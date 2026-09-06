{
  description = "my nixos config flake";
  inputs = import ./meta/inputs.nix;
  outputs = inputs @ {
    self,
    sops-nix,
    nixpkgs,
    home-manager,
    sundry-input,
    hyprland,
    nixos-cli,
    ...
  }: let
    username = "terrame";
    hosts = import ./meta/hosts.nix;
  in {
    nixosConfigurations = builtins.foldl' (acc: x: acc // x) {} (
      map (host: let
        pkgs = import nixpkgs {inherit (host) system;};
        sundry = sundry-input.mk-lib {inherit pkgs;};
        config-root = self.outPath;
        lib = pkgs.lib;
        module-args = {
          inherit inputs;
          inherit username;
          inherit host;
          inherit config-root;
          inherit sundry;
          inherit settings;
          inherit design-system;
        };
        design-system = import ./meta/design-system {inherit sundry lib;};
        settings = lib.pipe ./meta/settings [
          sundry.vfs.dir.from-src
          sundry.vfs.dir.load-nix
          (sundry.vfs.dir.collapse
            (path: file: {${sundry.vfs.path.get.stem path} = file.expr;}))
          sundry.attrs.merge.recursive.no-collision
        ];
        modules = lib.pipe config-root [
          sundry.vfs.dir.from-src
          (sundry.vfs.dir.filter
            (path: file: sundry.vfs.path.get.ext path == "nix"))
          sundry.vfs.dir.resolve-tags
          (sundry.vfs.dir.select-by-tag
            (_:
              with _;
                (tag {modules = [];})
                && !(tag {parts = [];} || tag {dotfiles = [];})
                && (tag {hosts = host.name;} || !tag {hosts = [];})))
        ];
        filter-modules = tag-value:
          lib.pipe modules [
            (sundry.vfs.dir.select-by-tag (_: with _; deepest-tag {modules = tag-value;}))
            (sundry.vfs.dir.collapse (path: file: file.origin))
          ];
        home-manager-config.home-manager = {
          extraSpecialArgs = module-args;
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "hm-backup";
          users.${username}.imports =
            (filter-modules "user")
            ++ [
              inputs.zen-browser.homeModules.beta
            ];
        };
      in {
        ${host.name} = nixpkgs.lib.nixosSystem {
          specialArgs = module-args;
          inherit (host) system;
          modules =
            (filter-modules "system")
            ++ [
              nixos-cli.nixosModules.nixos-cli
              hyprland.nixosModules.default
              home-manager.nixosModules.home-manager
              sops-nix.nixosModules.sops
              home-manager-config
            ];
        };
      })
      hosts
    );
  };
}
