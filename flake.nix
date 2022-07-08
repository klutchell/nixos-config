# https://nixos.wiki/wiki/Flakes
{
  description = "NixOS configuration";

  # All inputs for the system
  inputs = {
      nixpkgs.url = "github:nixos/nixpkgs";

      nix.url = "github:nixos/nix";

      flake-compat.url = "github:edolstra/flake-compat";
      flake-compat.flake = false;

      sops-nix.url = github:Mic92/sops-nix;
      sops-nix.inputs.nixpkgs.follows = "nixpkgs";

      home-manager.url = "github:nix-community/home-manager";
      home-manager.inputs.nixpkgs.follows = "nixpkgs";

      balena-cli.url = "gitlab:doronbehar/nix-balena-cli";
      balena-cli.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nix, home-manager, balena-cli, flake-compat, sops-nix }@inputs: let
    mkSystem = name: system: extraConfig: nixpkgs.lib.nixosSystem (nixpkgs.lib.recursiveUpdate {
      inherit system;
      modules = [
        (./machines + "/${name}/configuration.nix")
        (./machines + "/${name}/hardware-configuration.nix")
        self.nixosModules.base
      ] ++ [ extraConfig ];
    } {});
  in {
    nixosConfigurations = {
      # Personal Dell XPS 13
      neptune = mkSystem "neptune" "x86_64-linux" {};
      # Work System76 Oryx Pro 6
      jupiter = mkSystem "jupiter" "x86_64-linux" {};
    };

    nixosModules = {
      base = {
        imports = [
          home-manager.nixosModules.home-manager
          sops-nix.nixosModules.sops
          ({
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
              extraSpecialArgs = { inherit inputs; };
              users.kyle = import ./home;
            };
          })
          ({
            nixpkgs.overlays = [
              balena-cli.overlay
              # nix.overlay
            ];
          })
          ({
            nix.registry.nixpkgs.flake = nixpkgs;
          })
          # (import ./cachix.nix)
        ];
      };
    };

  };

}
