#!/usr/bin/env bash
set -e

echo
read -p "Container size (e.g. 5G): " SIZE
echo
read -p "Directory name for secure container: " DIR
echo
CONTAINER="$HOME/${DIR}.img"
MOUNT="$HOME/$DIR"

mkdir -p "$MOUNT"
fallocate -l "$SIZE" "$CONTAINER"
chmod 600 "$CONTAINER"

echo
echo "Set a password for your container:"
echo
cryptsetup luksFormat --type luks2 --cipher aes-xts-plain64 --key-size 512 "$CONTAINER"
cryptsetup open "$CONTAINER" "${DIR}_crypt"

mkfs.ext4 /dev/mapper/"${DIR}_crypt"
mount /dev/mapper/"${DIR}_crypt" "$MOUNT"

echo
echo "Secure container mounted at: $MOUNT"
echo