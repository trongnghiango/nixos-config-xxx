{
  description = "NixOS multi-machine configuration with Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      mkHost = name: {
        inherit system;
        modules = [
          ./hosts/${name}/hardware-configuration.nix
          ./hosts/${name}/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ka = import ./home/ka/default.nix;
          }
        ];
      };
    in {
      nixosConfigurations = {
        laptop = nixpkgs.lib.nixosSystem (mkHost "laptop");
        server = nixpkgs.lib.nixosSystem (mkHost "server");
        vm     = nixpkgs.lib.nixosSystem (mkHost "vm");
      };
    };
}
