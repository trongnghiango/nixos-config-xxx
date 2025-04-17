#!/bin/bash

# Thiết lập cấu trúc thư mục
echo "Tạo cấu trúc thư mục NixOS repo..."

# Tạo thư mục cho repo
mkdir -p nixos-config/{hosts/{laptop,server,vm},home/ka/qtile,modules}

# Tạo file flake.nix
cat <<EOF > nixos-config/flake.nix
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
          ./hosts/\${name}/hardware-configuration.nix
          ./hosts/\${name}/configuration.nix
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
EOF

# Tạo file common.nix
cat <<EOF > nixos-config/modules/common.nix
{ config, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  time.timeZone = "Asia/Ho_Chi_Minh";
  networking.networkmanager.enable = true;
}
EOF

# Tạo file cấu hình cho laptop
cat <<EOF > nixos-config/hosts/laptop/configuration.nix
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
EOF

# Tạo file cấu hình cho home/ka/default.nix
cat <<EOF > nixos-config/home/ka/default.nix
{ config, pkgs, ... }:

{
  home.username = "ka";
  home.homeDirectory = "/home/ka";
  home.stateVersion = "24.11";

  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo i use nixos btw";
      nrs = "sudo nixos-rebuild switch";
    };
    initExtra = ''
      export PS1='\\[\e[38;5;76m\]\\u\\[\e[0m\] in \\[\e[38;5;32m\]\\w\\[\e[0m\] \\$ '
    '';
  };

  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.9;
      font.normal = {
        family = "JetBrains Mono";
        style = "Regular";
      };
      font.size = 14;
    };
  };

  programs.neovim = {
    enable = true;
    extraConfig = ''
      set number
      set relativenumber
    '';
  };

  home.file.".config/bat/config".text = ''
    --theme="Nord"
    --style="numbers,changes,grid"
    --paging=auto
  '';

  home.file.".config/qtile".source = ./qtile;

  home.packages = with pkgs; [
    bat
    neofetch
  ];
}
EOF

# Tạo cấu hình Qtile
mkdir -p nixos-config/home/ka/qtile
cat <<EOF > nixos-config/home/ka/qtile/config.py
# Qtile configuration file
from libqtile import layout, bar, widget
from libqtile.config import Screen

# Layouts
layouts = [
    layout.Max(),
    layout.Tile(),
]

# Screens
screens = [
    Screen(top=bar.Bar([widget.CurrentLayout(), widget.Clock(format="%H:%M:%S")], 24)),
]
EOF

# Tạo file .gitignore
cat <<EOF > .gitignore
__pycache__/
*.pyc
EOF

# Hiển thị thông báo hoàn thành
echo "Cấu trúc repo đã được tạo xong!"

