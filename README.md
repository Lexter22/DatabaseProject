# Library Management and Catalog System

A comprehensive database project that tracks book inventory, borrowers, and penalties with full automation.

## Project Overview

This system demonstrates advanced database concepts including:
- Database creation and normalization
- SQL joins and complex queries
- Triggers and stored procedures
- Data backup and restore
- Role-based security

## Features

- **Books Management**: Track book inventory with availability status
- **User Management**: Role-based access (Admin, Librarian, Student)
- **Borrowing System**: Complete borrow/return workflow
- **Penalty System**: Automated overdue and lost book penalties
- **Data Operations**: Import/Export book records
- **Security**: Role-based permissions and access control

## Database Schema

### Tables
- `Roles`: User role definitions
- `Users`: System users with role assignments
- `Books`: Book inventory and metadata
- `BorrowLogs`: Borrowing transaction history
- `Penalty`: Penalty tracking for overdue/lost books

## Project Deliverables

- [x] Normalized ERD with relationship rules
- [x] SQL scripts for database & sample data
- [ ] DML operations for borrowing/returning books
- [ ] Queries for available vs borrowed books
- [ ] Overdue borrowers query (subquery)
- [ ] Stored procedure for penalty computation
- [ ] Trigger to update penalty or book status
- [ ] View: Active Borrowed Books summary
- [ ] Import/Export: Excel book inventory
- [ ] Backup/Restore: SQL dump
- [ ] Test report & presentation

## How to Contribute

### Branch Naming Convention

Create a new branch for each feature using the following format:
```
feature-name
```

**Examples:**
- `penalty-computation-procedure`
- `overdue-borrowers-query`
- `book-status-trigger`
- `excel-import-export`
- `backup-restore-scripts`

### Getting Started

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd DatabaseProject
   ```

2. **Create your feature branch**
   ```bash
   git checkout -b your-feature-name
   ```

3. **Set up the database**
   ```bash
   mysql -u root -p < database.sql
   ```

## Local Testing

### Prerequisites
- MySQL Server installed and running
- MySQL client or MySQL Workbench
- Git for version control

### Setup Instructions

1. **Start MySQL service**
   ```bash
   # macOS (using Homebrew)
   brew services start mysql
   
   # Windows
   net start mysql
   
   # Linux
   sudo systemctl start mysql
   ```

2. **Create and populate database**
   ```bash
   mysql -u root -p < database.sql
   ```

3. **Verify installation**
   ```sql
   mysql -u root -p
   USE LibrarySystem;
   SHOW TABLES;
   SELECT * FROM Books;
   ```

### Testing Your Features

1. **Test queries**
   ```bash
   mysql -u root -p LibrarySystem < your-query-file.sql
   ```

2. **Test procedures/triggers**
   ```sql
   -- Connect to MySQL
   mysql -u root -p LibrarySystem
   
   -- Test your procedure
   CALL YourProcedureName(parameters);
   
   -- Test triggers by inserting/updating data
   INSERT INTO BorrowLogs VALUES (...);
   ```

3. **Verify results**
   ```sql
   SELECT * FROM TableName WHERE condition;
   ```

### Development Workflow

1. **Work on your assigned feature**
   - Follow the project deliverables checklist
   - Test your SQL scripts thoroughly
   - Document any new procedures or functions

2. **Commit your changes**
   ```bash
   git add .
   git commit -m "Add: [feature description]"
   ```

3. **Push your branch**
   ```bash
   git push origin your-feature-name
   ```

4. **Create a Pull Request**
   - Provide clear description of changes
   - Reference the deliverable item completed
   - Include test results if applicable

### Code Standards

- **SQL Formatting**: Use consistent indentation and capitalization
- **Comments**: Add comments for complex queries and procedures
- **Naming**: Use descriptive names for tables, columns, and procedures
- **Testing**: Include sample data and test cases for new features

### File Structure

```
DatabaseProject/
├── README.md
├── database.sql          # Main database schema and sample data
├── queries/             # Directory for query files
├── procedures/          # Directory for stored procedures
├── triggers/           # Directory for trigger definitions
├── views/              # Directory for view definitions
├── import-export/      # Directory for data import/export scripts
├── backup/             # Directory for backup/restore scripts
└── tests/              # Directory for test scripts and reports
```

### Feature Assignment

Each team member should work on specific deliverables:

**Database Operations:**
- DML operations for borrowing/returning books
- Queries for available vs borrowed books
- Overdue borrowers query with subqueries

**Automation:**
- Stored procedure for penalty computation
- Triggers for penalty and book status updates
- Views for active borrowed books summary

**Data Management:**
- Excel import/export functionality
- Database backup and restore scripts
- Test report and documentation

### Testing Guidelines

- Test all SQL scripts with the provided sample data
- Verify triggers work correctly with INSERT/UPDATE operations
- Ensure stored procedures handle edge cases
- Document test results in the `tests/` directory

### Questions or Issues?

If you encounter any issues or have questions about your assigned feature, please:
1. Check existing documentation
2. Review similar implementations in the codebase
3. Ask for help in the team chat
4. Create an issue in the repository

## Current Status

✅ **Completed:**
- Database schema creation
- Sample data insertion
- Basic table relationships

🚧 **In Progress:**
- Feature development by team members

📋 **Next Steps:**
- Implement remaining deliverables
- Create comprehensive test suite
- Prepare final presentation

---

**Happy Coding!** 🚀