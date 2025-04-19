{ config, pkgs, ... }:

{
  imports = [
    ../../modules/common.nix
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "vm";

services = {
  xserver = {
    enable = true;
    layout = "us";

    displayManager = {
      lightdm = {
        enable = true;
        greeters.slick.enable = true;
        greeters.slick.extraConfig = ''
          theme-name=Adwaita-dark
          icon-theme-name=Papirus-Dark
          font-name=JetBrainsMono 12
        '';
      };

      sessionCommands = ''
        xrandr --output Virtual-1 --mode 1360x768
        xwallpaper --zoom ~/walls/castle.jpg
        xset r rate 200 35 &
        picom --experimental-backends &
      '';
    };

    windowManager.qtile = {
      enable = true;
      package = pkgs.python3Packages.qtile;
    };

    extraConfig = ''
      Section "Monitor"
        Identifier "Virtual-1"
        Option "PreferredMode" "1360x768"
      EndSection
    '';
  };
};
  programs.dconf.enable = true;

  environment.etc."greetd/environments".text = ''
    startx /run/current-system/sw/bin/qtile start
    bash
  '';

  users.users.ka = {
    isNormalUser = true;
    home = "/home/ka";
    extraGroups = [ "wheel" ];
  };

  environment.systemPackages = with pkgs; [
    gcc
    pkg-config
    cmake
    neovim
    lightdm-gtk-greeter
    papirus-icon-theme
    wget
    alacritty
    btop
    xwallpaper
    pcmanfm
    rofi
    git
    pfetch
  ];

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
    fontconfig.defaultFonts.monospace = [ "JetBrainsMono Nerd Font Mono" ];
  };

  services.openssh.enable = true;

  system.stateVersion = "24.11";
}

