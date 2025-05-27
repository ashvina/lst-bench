#!/bin/bash

# Mount data disk for Spark local directory
DISK="/dev/nvme1n1"
MOUNT="/mnt/local-disk"

# Create mount point
sudo mkdir -p $MOUNT

# Format disk if needed
if ! sudo file -s $DISK | grep -q filesystem; then
  sudo mkfs -t ext4 $DISK
fi

# Mount disk (only if not already mounted)
if ! mount | grep -q "$DISK on $MOUNT"; then
  sudo mount $DISK $MOUNT
  echo "Local disk mounted successfully."
else
  echo "Local disk is already mounted at $MOUNT."
fi

# Create and set permissions
sudo mkdir -p $MOUNT/spark
sudo chmod 777 $MOUNT/spark

# Add to fstab for persistence
if ! grep -q "$DISK" /etc/fstab; then
  echo "$DISK $MOUNT ext4 defaults,nofail 0 0" | sudo tee -a /etc/fstab
fi

# Show result
df -h $MOUNT
