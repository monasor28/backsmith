BackSmith for Wordpress.
=======================

BackSmith is a well written backup script for Wordpress - the most popular CMS on earth. I wrote it, because i do not want to install a backup plugin on my wordpress site or on any wordpress site i manage. I try my best to conserve resource's, though i have not measure the amount of memory BackSmith consumes will running.

What It Can Do !
=================

BackupSmith can make a compress file from your site directory (wp-content or whatever you have). And, also make a mysql dump of your databases. These files are compress using tar and uploaded using Grive.

What It Can't Do ! 
==================

Google drive gives a maximum of 10gb on your drive account. Hence , grive cannot upload a file > 10gb . You will recieve a message, if upload fails.

BackupSmith is written to manage one backup copy of your sites compressed backup file.Once, the backup file is uploaded to google drive - BackSmith, rm the file - your backup remains on google's servers until the next sync. Where it deletes the old backup file on google's servers and uploads the latest file.

Setup Instructions !
====================

1. Go to http://goo.gl/bENVR and follow the instructions , for Grive installation.
2. run - sudo apt-get install python-software-properties , before running sudo add-apt command. 
3. Log into your google account as, grive will have to gain permissions for storage.
4. run grive -a to give permission to grive on the 'grive_dir' (backup_dir)
5. Now, you can fill up your credentials and run the script via cronjobs to backup.


Appreciation !
==============
1. drive.google.com
2. www.webupd8.org
3. www.lbreda.com

Features to be added include: 

1. sms notification
2. multi-backup-archive management

