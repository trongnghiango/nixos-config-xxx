{ config, pkgs, ... }:

{
  imports = [ ../../modules/common.nix ];

  networking.hostName = "laptop";
  services.xserver.enable = true;
  services.displayManager.defaultSession = "qtile";
  services.xserver.windowManager.qtile.enable = true;

  users.users.ka = {
    isNormalUser = true;
    home = "/home/ka";
    extraGroups = [ "wheel" ];
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    alacritty
    btop
    xwallpaper
    pcmanfm
    rofi
    git
    pfetch
  ];

  fonts.packages = with pkgs; [ jetbrains-mono ];

  services.openssh.enable = true;
  system.stateVersion = "24.11";
}
