{ mylib, ... }: {
  imports = mylib.scanPath ./.;
}
