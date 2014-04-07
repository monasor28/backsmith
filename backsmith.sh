#!/bin/bash

# This script creates a compressed backup archive of the given directory and the given MySQL table. More details on implementation here: http://theme.fm
# Feel free to use this script wherever you want, however you want. We produce open source, GPLv2 licensed stuff.
# Author: Monasor JJ Atairu
# Thanks to Konstantin Kovshenin

# Set the date format, filename and the directories where your backup files will be placed and which directory will be archived.
now=$(date +"%Y-%m-%d-%H%M")
complete=$(date +"content.%Y-%m-%d-%H%M")
FILE="estella.$now.tar"
#BACKUP_DIR="/var/www/estellabackup"
www_dir="/var/www/estellamodelschool.com/wp-content/"
site_name="estella"
grive_dir="/var/www/estellabackup"
upload="$site_name.backup.$now"
grive_dir_noforwardslash="var/www/estellabackup"

#Admin info
admin_name="love_decay"
admin_email="love_decay@hotmail.com"

# MySQL database credentials
DB_USER="LLCKcWrXtJBR"
DB_PASS="oEml90cTLZAQ"
DB_NAME="estella"
DB_FILE="db.$now.sql"
host="localhost"

#move into wp-content and tar the archive
tar -czvf $grive_dir/$site_name.$complete.tar.gz  $www_dir

#next we get the mysql files
mysqldump -u$DB_USER -p$DB_PASS -h$host $DB_NAME > /tmp/$site_name.$DB_FILE

#ls -lha /var/www/estellabackup ; ls -lha /tmp/

#next we crunch the db files and sent to backup directory
tar -czvf $grive_dir/$site_name.$DB_FILE.tar.gz -C / tmp/$site_name.$DB_FILE && rm /tmp/$site_name.$DB_FILE

#next tar both files
tar -czvf $grive_dir/$upload.tar.gz -C / $grive_dir_noforwardslash/$site_name.$DB_FILE.tar.gz -C / $grive_dir_noforwardslash/$site_name.$complete.tar.gz 

rm $site_name.$DB_FILE.tar.gz ; rm $site_name.$complete.tar.gz 
#ls -lha $grive_dir
cd $grive_dir ;  grive 
#cd $grive_dir ; grive 
if [ $? -ne 0 ];
then
echo "Upload has failed"
else
echo "Grive has succesfully uploaded your backup of $site_name . You can find it at http://drive.google.com as $upload.tar.gz. $admin_name , please log into your google account
before attempting to access your backup file." | mailx -s 'Backup of '$site_name' on '$now'' $admin_email
fi

rm $upload.tar.gz
