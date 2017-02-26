#!/usr/bin/env bash
# Usage:
# ./backup.sh [target-file.tgz]
# If target is missing, it will use "backups/<time>.<uuid>.tgz"

# Exit with nonzero exit code if anything fails
set -e

# Absolute path to the root of the project (root of the repo)
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)"
# Generate random 32 character alphanumeric string
BACKUP_UUID=$(head -c 256 /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
# Read target file path or generate a default path based on the time and a random uuid
TARGET_FILE=${1:-"$PROJECT_ROOT/backups/`date --iso-8601=date`.$BACKUP_UUID.tgz"}

echo "Starting backup to: $TARGET_FILE"

# Absolute path to a random temporary directory
BACKUP_ROOT=`mktemp -d`
# Read the config of the project
source "$PROJECT_ROOT/.env"
# Dump the database
mysqldump --host="$DB_HOST" --user="$DB_USER" --password="$DB_PASSWORD" "$DB_NAME" > "$BACKUP_ROOT/mysqldump.sql"
# Copy the uploads
cp -r "$PROJECT_ROOT/web/app/uploads/" "$BACKUP_ROOT/uploads/"
# Build archive
cd "$BACKUP_ROOT" && tar --create --gzip --file="$TARGET_FILE" .
# Clean up
rm -r "$BACKUP_ROOT"

echo "Backup saved at:"
echo "$TARGET_FILE"
