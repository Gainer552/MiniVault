#!/usr/bin/env bash
set -e

read -p "Container size (e.g. 5G): " SIZE
read -p "Directory name for secure container: " DIR
CONTAINER="$HOME/${DIR}.img"
MOUNT="$HOME/$DIR"

mkdir -p "$MOUNT"
fallocate -l "$SIZE" "$CONTAINER"
chmod 600 "$CONTAINER"

echo "Set a password for your container:"
cryptsetup luksFormat --type luks2 --cipher aes-xts-plain64 --key-size 512 "$CONTAINER"
cryptsetup open "$CONTAINER" "${DIR}_crypt"

mkfs.ext4 /dev/mapper/"${DIR}_crypt"
mount /dev/mapper/"${DIR}_crypt" "$MOUNT"

echo "Secure container mounted at: $MOUNT"
