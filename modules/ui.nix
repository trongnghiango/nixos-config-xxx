{ pkgs,config, ... }:
{
  config = {
    home.packages = with pkgs; [
      adapta-gtk-theme
      papirus-icon-theme
      breeze-gtk
      gnome-themes-extra
			#gruvbox-material-gtk-theme
			gruvbox-dark-gtk
			gruvbox-dark-icons-gtk

			lxappearance  # Công cụ thay đổi theme GTK
    	libsForQt5.qt5ct         # Cấu hình theme cho ứng dụng Qt
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


		# gtk
	  gtk = {
      enable = true;
			theme = {
				name = "Gruvbox-Dark-BL";
				package = pkgs.gruvbox-dark-gtk;
			};
			iconTheme = {
				name = "Gruvbox-Dark";
				package = pkgs.gruvbox-dark-icons-gtk;
			};
      #iconTheme = {
      #  name = "Papirus-Dark";
      #  package = pkgs.papirus-icon-theme;
      #};

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

		# Cấu hình QT/QGtkStyle
		qt = {
			enable = true;
			platformTheme = "gtk";
			style.name = "gtk2";
		};
  };
}

