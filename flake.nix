# https://nixos.wiki/wiki/Flakes
{
  description = "NixOS configuration";

  # All inputs for the system
  inputs = {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";

      home-manager = {
          url = "github:nix-community/home-manager/release-22.05";
          inputs.nixpkgs.follows = "nixpkgs";
      };

      balena-cli = {
          url = "gitlab:doronbehar/nix-balena-cli";
          inputs.nixpkgs.follows = "nixpkgs";
      };
  };

  outputs = { self, nixpkgs, home-manager, balena-cli, ... }@inputs: {
    nixosConfigurations.neptune = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useUserPackages = true;
            useGlobalPkgs = true;
            extraSpecialArgs = { inherit inputs; };
            users.kyle = import ./users/kyle/home.nix;
          };
          nixpkgs.overlays = [
            balena-cli.overlay
          ];
        }
      ];
      specialArgs = { inherit inputs; };
    }; 
  };
}
