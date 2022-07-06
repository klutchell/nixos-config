# https://nixos.wiki/wiki/Flakes
{
  description = "NixOS configuration";

  # All inputs for the system
  inputs = {
      nixpkgs.url = "github:nixos/nixpkgs";

      nix.url = "github:nixos/nix";

      flake-compat.url = "github:edolstra/flake-compat";
      flake-compat.flake = false;

      home-manager = {
          url = "github:nix-community/home-manager";
          inputs.nixpkgs.follows = "nixpkgs";
      };

      balena-cli = {
          url = "gitlab:doronbehar/nix-balena-cli";
          inputs.nixpkgs.follows = "nixpkgs";
      };
  };

  outputs = { self, nixpkgs, nix, home-manager, balena-cli, flake-compat }: let
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
          ({
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
              # extraSpecialArgs = { inherit inputs; };
              users.kyle = import ./users/kyle/home.nix;
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
          (import ./cachix.nix)
          ({
            # https://github.com/andyrichardson/nix-node
            nix.registry."node".to = {
              type = "github";
              owner = "andyrichardson";
              repo = "nix-node";
            };
            nix.settings.substituters = [ "https://cache.nixos.org/" "https://nix-node.cachix.org/" ];
          })
        ];
      };
    };

  };

}
