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
	  # Chạy pywal khi đăng nhập
      # wal --theme nord
    '';
  };

  home.sessionVariables = {
    WAL_THEME = "nord";
  };

  # Tạo file gtk.css từ pywal (sẽ được cập nhật bởi wal --theme nord)
  home.file.".config/gtk-3.0/gtk.css".text = ''
    /* Nội dung sẽ được pywal ghi đè khi chạy wal --theme nord */
  '';
  home.file.".xprofile".text = ''
    #!/bin/sh
    wal --theme nord
  '';
  home.file.".xprofile".executable = true;

  home.file.".config/qtile".source = ./qtile;

  home.file.".config/nvim".source = ./nvim;

  home.packages =  with pkgs; [
    bat
    neofetch
	tree
  ];

}
