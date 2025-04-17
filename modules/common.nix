{ config, pkgs, ... }:{
  imports = [
    #./ui.nix
    #./neovim.nix
    # thêm các module khác nếu cần
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  time.timeZone = "Asia/Ho_Chi_Minh";
  networking.networkmanager.enable = true;
}
