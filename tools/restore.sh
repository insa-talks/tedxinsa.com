#!/usr/bin/env bash
# Usage:
# ./restore.sh path/to/backup.tgz

# Exit with nonzero exit code if anything fails
set -e

if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    exit 1
fi

SOURCE_FILE=`readlink -f "$1"`
# Absolute path to the root of the project (root of the repo)
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)"
# Absolute path to a random temporary directory
TMP_ROOT=`mktemp -d`
# Extract the backup
cd "$TMP_ROOT" && tar -xzf "$SOURCE_FILE"
# Read the config of the project
source "$PROJECT_ROOT/.env"
# Restore the database
mysql "$DB_NAME" -h "$DB_HOST" -u "$DB_USER" --password="$DB_PASSWORD" < "$TMP_ROOT/mysqldump.sql"
# Restore the uploads
cp -r "$TMP_ROOT/uploads" "$PROJECT_ROOT/web/app/uploads/"
