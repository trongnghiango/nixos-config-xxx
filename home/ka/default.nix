{ config, pkgs, ... }:
{
  imports = [
    # import thêm nếu cần
	../../modules/ui.nix
  ];
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
      export PS1='\[\e[38;5;76m\]\u\[\e[0m\] in \[\e[38;5;32m\]\w\[\e[0m\] \$ '
    '';
  };


  home.file.".config/qtile".source = ./qtile;

  home.file.".config/nvim".source = ./nvim;

  home.packages =  with pkgs; [
    bat
    neofetch
	tree
	# for GTK-(2/3)
	#adapta-gtk-theme          # GTK theme
    #papirus-icon-theme        # Icon
    #breeze-gtk                # GTK engine
    #gnome-themes-extra        # Required for GTK 2 support
  ];

}
