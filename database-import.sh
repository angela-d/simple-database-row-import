#!/bin/bash

DATE="`date +%m-%d-%y-%s`"

#database config
DB_USER="your_database_username"
DB_PW="your_database_password"
DB_CNF="your_database"
TABLE_TARGET="the_database_table"
TABLE_ROW_TARGET="the_database_row"
KEY_TARGET="the_key_you_want_to_target"
SCHEMA_LOCATION="/your/path/to/import.sql"
BACKUP_DIRECTORY="/your/path/to/store/backups/"
#do not edit below this line

#backup
echo "  Backing up the database..."
mysqldump -u"$DB_USER" -p"$DB_PW" --host=localhost "$DB_CNF" > "$BACKUP_DIRECTORY"/"$DB_CNF"-"$DATE".sql

#purge the affected rows
echo "  Purging the "$KEY_TARGET" rows..."
echo "DELETE FROM "$TABLE_TARGET" WHERE "$TABLE_ROW_TARGET" = '"$KEY_TARGET"'" | mysql -u"$DB_USER" -p"$DB_PW" --host=localhost "$DB_CNF"

#import the new rows
echo "  Importing "$SCHEMA_LOCATION""
mysql -u "$DB_USER" -p"$DB_PW" "$DB_CNF" < "$SCHEMA_LOCATION"

echo "  IMPORT COMPLETE!"
