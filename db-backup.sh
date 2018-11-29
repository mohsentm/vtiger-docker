#!/bin/bash

# exit when any command fails
set -e

echo 'Start backup database'

BACKUP_DIR="/home/test/CRM_Backup"
CONTAINER="${PWD##*/}_db_1"
DIR_NAME=$(date '+%Y-%m-%d')
 FILE_NAME="db_$(date '+%Y-%m-%d_%H:%M:%S')"

echo "Container name $CONTAINER" 
echo "Check backup directory is exist";
echo $BACKUP_DIR/$DIR_NAME

if [ ! -d $BACKUP_DIR/$DIR_NAME ]; then
	mkdir -p $BACKUP_DIR/$DIR_NAME
        echo "Create directory $DIR_NAME"
fi

echo "Start get dump from database"
docker exec ${PWD##*/}_db_1 sh -c 'exec mysqldump --all-databases -u$MYSQL_USER -p"$MYSQL_PASSWORD"' > $BACKUP_DIR/$DIR_NAME/$FILE_NAME.sql
