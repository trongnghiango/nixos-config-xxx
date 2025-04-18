#!/usr/bin/env bash

# Script: build_nixos.sh
# Purpose: Generate hardware config and build NixOS for a specified hostname (default: vm)

# Default hostname
HOST="vm"

# Parse command-line arguments for --host
while [ $# -gt 0 ]; do
    case "$1" in
        --host=*)
            HOST="${1#*=}"
            shift
            ;;
        *)
            echo "Error: Unknown argument '$1'. Use --host=<hostname>."
            exit 1
            ;;
    esac
done

# If no valid hostname provided, prompt user
if [ "$HOST" = "vm" ] && [ $# -eq 0 ]; then
    read -p "Enter hostname (default: $HOST): " input
    if [ -n "$input" ]; then
        HOST="$input"
    fi
fi

# Validate hostname (simple check for non-empty and alphanumeric)
if [ -z "$HOST" ] || ! echo "$HOST" | grep -q '^[a-zA-Z0-9-]\+$'; then
    echo "Error: Invalid hostname '$HOST'. Use alphanumeric characters and hyphens only."
    exit 1
fi

# Print selected hostname
echo "Building NixOS for hostname: $HOST"

# Check if hosts directory exists for the hostname
HOST_DIR="./hosts/$HOST"
if [ ! -d "$HOST_DIR" ]; then
    echo "Error: Directory $HOST_DIR does not exist."
    exit 1
fi

# Clean Nix cache
echo "Cleaning Nix cache..."
sudo nix-collect-garbage
nix flake lock
nix flake metadata --refresh

# Generate hardware configuration
HARDWARE_CONFIG="$HOST_DIR/hardware-configuration.nix"
echo "Generating hardware configuration to $HARDWARE_CONFIG..."
sudo nixos-generate-config --show-hardware-config > "$HARDWARE_CONFIG"

# Check if hardware configuration was generated successfully
if [ $? -ne 0 ]; then
    echo "Error: Failed to generate hardware configuration."
    exit 1
fi

# Build and switch to the new configuration
echo "Running nixos-rebuild switch for $HOST..."
sudo nixos-rebuild switch --flake .#$HOST

# Check if build was successful
if [ $? -eq 0 ]; then
    echo "Build successful for $HOST!"
    # Commit changes to git
    git add "$HARDWARE_CONFIG"
    git commit -m "Update hardware-configuration.nix for $HOST"
    exit 0
else
    echo "Build failed for $HOST. Check logs:"
    journalctl -u nixos-rebuild.target
    exit 1
fi
