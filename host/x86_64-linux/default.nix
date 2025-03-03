{ mylib, lib, ... } @ args: let
  system = builtins.baseNameOf ./.;
  hosts = mylib.getDirNames ./.;
in {
  sl-laptop = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit args; };
    modules = [ 
      ./sl-laptop/configuration.nix
      ../../module 
    ];
  };
}

