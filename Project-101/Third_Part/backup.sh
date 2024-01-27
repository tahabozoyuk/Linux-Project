#!/bin/bash

# Check if we are root privilage or not
if [ "$EUID" -ne 0 ]
  then echo "Bu scripti çalıştırmak için root yetkilerine ihtiyaç vardır."
  fi  


# Which files are we going to back up. Please make sure to exist /home/ec2-user/data file


cd /home/ec2-user/data
# Where do we backup to. Please crete this file before execute this script
mkdir /home/ec2-user/data
source_directory="/home/ec2-user/data"
backup_destination="/mnt/backup"
mkdir /mnt/backup
# Create archive filename based on time

archive_filename="backup_$(date +'%Y%m%d_%H%M%S').tar.gz"

# Print start status message.

echo "Yedek alma işlemi başlatılıyor..."

# Backup the files using tar.
tar -czf "$backup_destination/$archive_filename" "$source_directory"
tar -czf "$backup_destination/$archive_filename" "/boot"
tar -czf "$backup_destination/$archive_filename" "/etc"
tar -czf "$backup_destination/$archive_filename" "/usr"
# Print end status message.

echo "Yedek alma işlemi tamamlandı."

# Long listing of files in $dest to check file sizes.

ls -lh "$backup_destination"

-------------

# To set this script for executing in every 5 minutes, we'll create cronjob
crontab -e
*/5 * * * * /etc > backup.sh
