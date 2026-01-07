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
- [x] DML operations for borrowing/returning books
- [x] Queries for available vs borrowed books
- [x] Overdue borrowers query (subquery)
- [x] Stored procedure for penalty computation
- [x] Trigger to update penalty or book status
- [x] View: Active Borrowed Books summary
- [x] Import/Export: Excel book inventory
- [x] Backup/Restore: SQL dump
- [x] Test report & presentation
