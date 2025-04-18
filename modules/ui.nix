{ pkgs,config, ... }:
{
  config = {
    home.packages = with pkgs; [
      adapta-gtk-theme
      papirus-icon-theme
      breeze-gtk
      gnome-themes-extra
	  # pywal - nord 
	  python3Packages.pywal
	  nordic
    ];

    programs.alacritty = {
      enable = true;
      settings = {
        window.opacity = 0.8;
        font.normal = {
          family = "JetBrains Mono";
          style = "Regular";
        };
        font.size = 14;
      };
    };


    home.file.".config/bat/config".text = ''
      --theme="Nord"
      --style="numbers,changes,grid"
      --paging=auto
    '';


	gtk = {
      enable = true;

      theme = {
		name = "Nordic";
    	package = pkgs.nordic;
        # name = "Adapta-Nokto";
        # package = pkgs.adapta-gtk-theme;
      };

      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };

	  font = {
        name = "JetBrains Mono";
        package = pkgs.jetbrains-mono;
        size = 12;
      };
      # XÓA PHẦN cursorTheme Ở ĐÂY
    };

    # Thêm cấu hình cursor theme ở đây
    home.pointerCursor = {
      name = "Breeze";
      package = pkgs.breeze-gtk;
      size = 24;
    };

  };
}

