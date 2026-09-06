{
  description = "my nixos config flake";
  inputs = import ./meta/inputs.nix;
  outputs = inputs @ {
    self,
    nixpkgs,
    sundry-input,
    ...
  }: let
    username = "terrame";
    hosts = import ./meta/hosts.nix;
  in {
    nixosConfigurations = builtins.foldl' (acc: x: acc // x) {} (
      map (host: let
        config-root = self.outPath;
        pkgs = import nixpkgs {inherit (host) system;};
        sundry = sundry-input.mk-lib {inherit pkgs;};
        lib = pkgs.lib;
        design-system = import ./meta/design-system meta-args;
        module-args = {
          inherit
            design-system
            config-root
            settings
            username
            host
            sundry
            inputs
            ;
        };
        meta-args = {
          inherit
            module-args
            config-root
            username
            host
            sundry
            pkgs
            lib
            ;
        };
        settings = lib.pipe ./meta/settings [
          sundry.vfs.dir.from-src
          sundry.vfs.dir.load-nix
          (sundry.vfs.dir.collapse
            (path: file: {${sundry.vfs.path.get.stem path} = file.expr;}))
          sundry.attrs.merge.recursive.no-collision
        ];
      in {
        ${host.name} =
          nixpkgs.lib.nixosSystem
          ({inherit (host) system;} // (import ./meta/module-globbing meta-args));
      })
      hosts
    );
  };
}
