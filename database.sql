CREATE DATABASE IF NOT EXISTS LibrarySystem;
USE LibrarySystem;

-- 1. Table: Roles
CREATE TABLE Roles (
    RoleID INT AUTO_INCREMENT PRIMARY KEY,
    Role ENUM('Admin', 'Librarian', 'Student')
);

-- 2. Table: Users
CREATE TABLE Users (
    UserID VARCHAR(50) PRIMARY KEY, -- Formats: Admin-001, Student-001, etc.
    FullName VARCHAR(255),
    RoleID INT,
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
);

-- 3. Table: Books
CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    BookAuthor VARCHAR(255),
    BookTitle VARCHAR(255),
    PublishedYear INT,
    BookDescription VARCHAR(255),
    BookQuantity INT,
    BookStatus ENUM('Available', 'Unavailable'),
    BookGenre VARCHAR(100)
);

-- 4. Table: BorrowLogs
CREATE TABLE BorrowLogs (
    BorrowLogID INT AUTO_INCREMENT PRIMARY KEY,
    UserID VARCHAR(50),
    BookID INT,
    BorrowedDate DATE,
    DueDate DATE,
    ReturnDate DATE,
    Status ENUM('Borrowed', 'Returned', 'Lost'),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

-- 5. Table: Penalty
CREATE TABLE Penalty (
    BorrowLogID INT,
    ReturnDate DATE,
    DueDate DATE,
    BorrowedID INT,
    DaysOverdue INT,
    PenaltyAmount DECIMAL(8,2),
    PenaltyReason ENUM('Lost', 'Overdue'),
    FOREIGN KEY (BorrowLogID) REFERENCES BorrowLogs(BorrowLogID)
);
