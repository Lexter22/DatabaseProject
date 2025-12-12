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
    PenaltyReason ENUM('Lost', 'Overdue', 'Damage'),
    FOREIGN KEY (BorrowLogID) REFERENCES BorrowLogs(BorrowLogID)
);

-- INSERT DML
-- 1. Insert Roles
INSERT INTO Roles (Role) VALUES 
('Admin'), 
('Librarian'), 
('Student');

-- 2. Insert Users (Using specific UserID formats)
-- Assumptions: RoleID 1=Admin, 2=Librarian, 3=Student
INSERT INTO Users (UserID, FullName, RoleID) VALUES 
('Admin-001', 'John Doe', 1),
('Librarian-001', 'Jane Smith', 2),
('Student-001', 'Alice Johnson', 3),
('Student-002', 'Bob Williams', 3);

-- 3. Insert Books
INSERT INTO Books (BookAuthor, BookTitle, PublishedYear, BookDescription, BookQuantity, BookStatus, BookGenre) VALUES 
('George Orwell', '1984', 1949, 'Dystopian fiction', 5, 'Available', 'Sci-Fi'),
('J.K. Rowling', 'Harry Potter', 1997, 'Fantasy novel', 3, 'Unavailable', 'Fantasy');

-- 4. Insert BorrowLogs (Referencing the new UserIDs)
INSERT INTO BorrowLogs (UserID, BookID, BorrowedDate, DueDate, ReturnDate, Status) VALUES 
('Student-001', 1, '2023-10-01', '2023-10-10', '2023-10-12', 'Returned'), -- Late
('Student-002', 2, '2023-11-01', '2023-11-15', NULL, 'Lost');           -- Lost

-- 5. Insert Penalty
INSERT INTO Penalty (BorrowLogID, ReturnDate, DueDate, BorrowedID, DaysOverdue, PenaltyAmount, PenaltyReason) VALUES 
(1, '2023-10-12', '2023-10-10', 101, 2, 20.00, 'Overdue'),
(2, NULL, '2023-11-15', 102, 0, 50.00, 'Lost');
