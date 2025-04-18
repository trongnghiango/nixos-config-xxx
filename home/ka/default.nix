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
	  [[ -f "$HOME/.nprofile" ]] && source "$HOME/.nprofile"
    '';
  };

  home.sessionVariables = {
    WAL_THEME = "nord";
  };

  home.file.".config/wal/postrun".text = ''
#!/bin/sh
wal --theme nord
  '';

  home.file.".config/wal/postrun".executable = true;
	
  home.file.".config/gtk-3.0/gtk.css".source = "${config.home.homeDirectory}/.cache/wal/colors-gtk.css";

  home.file.".config/qtile".source = ./qtile;

  home.file.".config/nvim".source = ./nvim;

  home.packages =  with pkgs; [
    bat
    neofetch
	tree
  ];

}
