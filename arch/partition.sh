#!/usr/bin/env bash

set -e

if [[ -e /dev/sda ]]; then
       DRIVE=sda
fi
if [[ -e /dev/nvme0n1 ]]; then
       DRIVE=nvme0n1
       PARTITION_PREFIX=p
fi

echo "Partitioning disk"
parted --script -a optimal /dev/$DRIVE \
       mklabel gpt \
       mkpart primary 1MiB 512MiB \
       set 1 esp on \
       -- mkpart primary 512Mib -1

echo "Formatting boot partition"
BOOT_DEV="/dev/${DRIVE}${PARTITION_PREFIX}1"
mkfs.vfat -F32 $BOOT_DEV
