-- Backup and Restore Operations
-- Author: Database Team
-- Description: Scripts for database backup and restore operations

-- Create full backup with structure and data (run in terminal)
-- mysqldump -u root -p --routines --triggers --events LibrarySystem > backup_$(date +%Y%m%d_%H%M%S).sql

-- Create backup with specific tables only (run in terminal)
-- mysqldump -u root -p LibrarySystem Books Users BorrowLogs > essential_tables_backup.sql

-- Create structure-only backup (run in terminal)
-- mysqldump -u root -p --no-data LibrarySystem > structure_only_backup.sql

-- Create data-only backup (run in terminal)
-- mysqldump -u root -p --no-create-info LibrarySystem > data_only_backup.sql

-- Restore from backup (run in terminal)
-- mysql -u root -p LibrarySystem < backup_20231201_143022.sql

-- Create new database and restore (run in terminal)
-- mysql -u root -p -e "CREATE DATABASE LibrarySystem_Restored;"
-- mysql -u root -p LibrarySystem_Restored < backup_20231201_143022.sql

-- Automated backup script (save as backup.sh)
#!/bin/bash
# BACKUP_DIR="/path/to/backup/directory"
# DATE=$(date +%Y%m%d_%H%M%S)
# mysqldump -u root -p --routines --triggers --events LibrarySystem > "$BACKUP_DIR/library_backup_$DATE.sql"
# echo "Backup completed: library_backup_$DATE.sql"

-- Note: These are terminal commands, not SQL queries
-- Run them in your command line/terminal, not in MySQL client
-- Ensure you have proper permissions and MySQL is in your PATH