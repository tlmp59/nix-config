{ config, lib, pkgs, inputs, util, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${util.myvar.user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  # System settings 
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.supportedFilesystems = [ "btrfs" ];
  hardware.enableAllFirmware = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Options to reduce disk usage
  boot.loader.systemd-boot.configurationLimit = 10;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };
  nix.settings.auto-optimise-store = true;

  # Network connection
  # networking.hostName = hostname;
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Asia/Vietnam";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.autorun = false;
  services.xserver.displayManager.lightdm.enable = false;
  services.xserver.displayManager.startx.enable = true;
  services.getty.autologinUser = "tlmp59";
  services.xserver.windowManager.dwm.enable = true;

  # Enable sound daemon
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;


  # Default programs
  programs.firefox.enable = true;
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  virtualisation.docker.enable = true;

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    vim 
    git 
    st
    dmenu
    alacritty
  ];

  # -------------------------------------------------------
  # Do NOT change this value
  system.stateVersion = "24.11";
}

