#!/bin/bash
# Title: BackSmith for Wordpress
# Author: https://github.com/love-decay
# Short description: Backup mysql and site directory to google drive, include email and sms confirmation.
# License: MIT License.
# Version: 0.1
#==============================================================================
# ADJUST THESE VARIABLES BEFORE RUNNING THIS SCRIPT
#==============================================================================

#+++++++++++++++++++++++
#+DO NOT CHANGE THESE. +
#+++++++++++++++++++++++
now=$(date +"%Y-%m-%d-%H%M")
complete=$(date +"content.%Y-%m-%d-%H%M")
FILE="$sitename.$now.tar"
upload="$site_name.backup.$now"
DB_FILE="db.$now.sql"

#+++++++++++++++++++++++++++++
#+ENTER YOUR CREDENTIALS     +
#+++++++++++++++++++++++++++++
site_name=" keep_it_short "
site_ip="1.1.1.1"
www_dir="/var/www/your_site.com/wp-content/"
grive_dir="/this_is_ur_backup_dir_start_with_forward_slash_but_dont_end_with_forward_slash e.g /var/www/mk.com"
grive_dir_noforwardslash="same_as_above_BUT_DONT_start_with_forward_slash_DONT_end_with_forward_slash e.g var/www/mk.com"

#admin info
admin_name=" "
admin_email=" "

#database credentials
DB_USER=" "
DB_PASS=" "
DB_NAME=" "
host="localhost"

#move into wp-content and tar the archive
tar -czvf $grive_dir/$site_name.$complete.tar.gz  $www_dir

#next we get the mysql files
mysqldump -u$DB_USER -p$DB_PASS -h$host $DB_NAME > /tmp/$site_name.$DB_FILE

#next we crunch the db files and sent to backup directory
tar -czvf $grive_dir/$site_name.$DB_FILE.tar.gz -C / tmp/$site_name.$DB_FILE && rm /tmp/$site_name.$DB_FILE

#next tar both files
tar -czvf $grive_dir/$upload.tar.gz -C / $grive_dir_noforwardslash/$site_name.$DB_FILE.tar.gz -C / $grive_dir_noforwardslash/$site_name.$complete.tar.gz 

#then remove recently compressed directory and database
rm $site_name.$DB_FILE.tar.gz ; rm $site_name.$complete.tar.gz 

#go to grive dir 
cd $grive_dir ;  grive 
if [ $? -ne 0 ];
then
echo "Grive failed to upload your backup of $site_name on $site_ip. Last attempt was $now" | mailx -s 'Backup FAILED ! '$site_name' on '$now'' $admin_email
else
echo "Grive has succesfully uploaded your backup of $site_name . You can find it at http://drive.google.com as $upload.tar.gz. $admin_name , please log into your google account before attempting to access your backup file." | mailx -s 'Backup SUCCEDED ! '$site_name' on '$now'' $admin_email
fi

#remove archive uploaded to google drive
rm $upload.tar.gz
