{
  description = "Configuracao do NixOS de liborio com Home Manager integrado";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # global protect
    # globalprotect-openconnect.url = "github:yuezk/GlobalProtect-openconnect";
    #globalprotect-openconnect = {
    #  url = "github:yuezk/GlobalProtect-openconnect";
    #  rev = "8ed3304e61f3251d6ada48563146326492598a81";
    #};
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      # --- CONFIGURAÇÃO DO SISTEMA ---
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
         #specialArgs = { inherit inputs; };
	 modules = [
          ./configuration.nix

          # Integra o Home Manager ao flake
          home-manager.nixosModules.home-manager
          {
            home-manager.useUserPackages = true;
            home-manager.useGlobalPkgs = true;
            home-manager.users.liborio = import ./home.nix;
	 
	   
          }
        ];
      };
    };
}
