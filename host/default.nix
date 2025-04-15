{ inputs, lib, ulib, uvar }@specialArgs: let
  inherit (inputs) nix-darwin home-manager;

  genHosts = system: let
    sysHosts = ulib.dirsIn ./${system};

    sysAttrs = if lib.hasSuffix "darwin" system then {
      type = "darwin";
      conf = nix-darwin.lib.darwinSystem;
      home = home-manager.darwinModules;
    } else {
      type = "linux";
      conf = lib.nixosSystem;
      home = home-manager.nixosModules;
    };

  in with sysAttrs;
    lib.genAttrs sysHosts (
      hostname: conf {
        inherit system specialArgs;
        modules = [
	  ./${system}/${hostname}
	  ../module/${type} 
	  home.home-manager

	  { 
	    users.users."${uvar.user}" = {
	        isNormalUser = true;
	        extraGroups = [ "wheel" ];
	    };

	    home-manager.users."${uvar.user}".imports = [ 
	      ../home # --> Default for any users
	      ./${system}/${hostname}/home.nix 
	    ];

	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.extraSpecialArgs = { inherit ulib uvar; };

	    networking.hostName = hostname;
	  }
        ];
      }
    );

in {
  nixosConfigurations = lib.mergeAttrsList
    ( map genHosts uvar.systems.linux);

  darwinConfigurations = lib.mergeAttrsList
    ( map genHosts uvar.systems.darwin);
}
