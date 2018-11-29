#!/bin/bash

# exit when any command fails
set -e

echo 'Full backup crm'

BACKUP_DIR="/home/test/CRM_Backup"

DIR_NAME=$(date '+%Y-%m-%d')
FILE_NAME="full_$(date '+%Y-%m-%d_%H:%M:%S')"

echo "Check backup directory is exist";
echo $BACKUP_DIR/$DIR_NAME

if [ ! -d $BACKUP_DIR/$DIR_NAME ]; then
	mkdir -p $BACKUP_DIR/$DIR_NAME
        echo "Create directory $DIR_NAME"
fi

echo "Start get full backup"
tar -czvf $BACKUP_DIR/$DIR_NAME/$FILE_NAME.tar.gz $PWD
