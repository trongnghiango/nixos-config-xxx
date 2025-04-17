#!/usr/bin/env bash
set -euo pipefail

# Configuration Variables
DISK="/dev/sda"          # Điều chỉnh tên disk phù hợp
HOSTNAME="nixos-btw"
USERNAME="user"
TIMEZONE="Asia/Ho_Chi_Minh"
LOCALE="en_US.UTF-8"
KEYMAP="us"
BOOT_SIZE="512MiB"
SWAP_SIZE="4G"           # Nên bằng RAM hoặc 1.5x RAM nếu RAM < 8GB
ROOT_SIZE="100%FREE"

# Hàm chuẩn bị disk
prepare_disk() {
    # Xóa partition table cũ
    wipefs -af "$DISK"
    parted -s "$DISK" mklabel gpt

    # Tạo partitions
    parted -s "$DISK" mkpart ESP fat32 1MiB "$BOOT_SIZE"
    parted -s "$DISK" set 1 esp on
    parted -s "$DISK" mkpart primary linux-swap "$BOOT_SIZE" "$SWAP_SIZE"
    parted -s "$DISK" mkpart primary ext4 "$SWAP_SIZE" "$ROOT_SIZE"

    # Định dạng partitions
    mkfs.fat -F 32 -n boot "${DISK}1"
    mkswap -L swap "${DISK}2"
    mkfs.ext4 -L nixos "${DISK}3"

    # Mount partitions
    swapon "${DISK}2"
    mount /dev/disk/by-label/nixos /mnt
    mkdir -p /mnt/boot
    mount /dev/disk/by-label/boot /mnt/boot
}

# Hàm cấu hình hệ thống
configure_system() {
    # Generate base config
    nixos-generate-config --root /mnt

    # Thêm user và các cấu hình cần thiết
    cat <<EOF > /mnt/etc/nixos/configuration.nix
{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Basic configuration
  boot.loader.systemd-boot.enable = true;
  networking.hostName = "${HOSTNAME}";
  time.timeZone = "${TIMEZONE}";
  i18n.defaultLocale = "${LOCALE}";
  console.keyMap = "${KEYMAP}";

  # User configuration
  users.users.${USERNAME} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    initialPassword = "changeme";
  };

  # Enable SSH (optional)
  services.openssh.enable = true;

  # System packages
  environment.systemPackages = with pkgs; [
    vim wget curl git htop
  ];

  # Auto garbage collection
  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 7d";

  system.stateVersion = "23.11"; 
}
EOF
}

# Main installation process
main() {
    # Kiểm tra quyền root
    if [[ $(id -u) -ne 0 ]]; then
        echo "This script must be run as root!"
        exit 1
    fi

    # Chuẩn bị disk
    echo "### Preparing disk..."
    prepare_disk

    # Cấu hình hệ thống
    echo "### Configuring system..."
    configure_system

    # Cài đặt NixOS
    echo "### Installing NixOS..."
    nixos-install --no-root-passwd  # Bỏ qua mật khẩu root

    # Hoàn tất
    echo "### Installation complete!"
    echo "### Don't forget to:"
    echo "1. Set root password: passwd root"
    echo "2. Set user password: passwd ${USERNAME}"
    echo "3. Reboot the system: reboot"
}

# Chạy main function
main
