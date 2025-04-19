{ config, pkgs, ... }:

{
  imports = [ 
    ../../modules/common.nix 
    ./hardware-configuration.nix
  ];
  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "vm";
  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # bật dconf-service, và nó cần dbus để hoạt động.
  services.dbus.enable = true;
  programs.dconf.enable = true;

	# Định nghĩa các session có thể chọn
  environment.etc."greetd/environments".text = ''
		startx /run/current-system/sw/bin/qtile start
    bash
  '';


  # Bật display manager LightDM
  services.xserver.displayManager = {
    lightdm = {
			enable = true;

			greeters.slick = {
        enable = true;
        theme = {
          name = "Adwaita-dark";  # Có thể thay bằng "Gruvbox-Dark"
          package = pkgs.gnome.gnome-themes-extra;
        };
        iconTheme = {
          name = "Papirus-Dark";
          package = pkgs.papirus-icon-theme;
        };
      };
		};

    # Lệnh chạy sau khi đăng nhập vào session
    sessionCommands = ''
      xrandr --output Virtual-1 --mode 1360x768
      xwallpaper --zoom ~/walls/castle.jpg
      xset r rate 200 35 &
      picom --experimental-backends &
    '';
  };


  # Bật Window Manager Qtile
  services.xserver.windowManager.qtile = {
    enable = true;
  	package = pkgs.python3Packages.qtile; # Sử dụng gói đúng
  };

  # Tuỳ chọn: cấu hình màn hình cụ thể
  services.xserver.extraConfig = ''
    Section "Monitor"
      Identifier "Virtual-1"
      Option "PreferredMode" "1360x768"
    EndSection
  '';
  
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "backup"; # ✅ Đặt ở đây nè
  
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
		
		#greetd.tuigreet
		lightdm-gtk-greeter  # Cài GTK greeter cho LightDM
    papirus-icon-theme   # Nếu bạn muốn dùng theme biểu tượng
    #python3Packages.qtile
		#xorg.xinit # Cho startx
    # vim
    wget
    alacritty
    btop
    xwallpaper
    pcmanfm
    rofi
    git
    pfetch
  ];

  #fonts.packages = with pkgs; [ jetbrains-mono ];
	fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      # Cài đặt JetBrains Mono với Nerd Font patches
      (nerdfonts.override { 
        fonts = [ 
					"JetBrainsMono" 
				];  # Chỉ patch JetBrains Mono
      })
      
      # Hoặc cài tất cả Nerd Fonts (nặng hơn)
      # nerdfonts
    ];
    
    fontconfig = {
      defaultFonts = {
        monospace = [ "JetBrainsMono Nerd Font Mono" ];
      };
    };
  };

  services.openssh.enable = true;
  system.stateVersion = "24.11";
}

