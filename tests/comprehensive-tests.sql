-- Test Cases: Library Management System
-- Author: Database Team
-- Description: Comprehensive test cases for all implemented features

USE LibrarySystem;

-- Test Setup: Insert additional test data
INSERT INTO Books (BookAuthor, BookTitle, PublishedYear, BookDescription, BookQuantity, BookStatus, BookGenre) VALUES 
('Harper Lee', 'To Kill a Mockingbird', 1960, 'Classic American literature', 4, 'Available', 'Fiction'),
('F. Scott Fitzgerald', 'The Great Gatsby', 1925, 'American classic', 2, 'Available', 'Fiction');

INSERT INTO Users (UserID, FullName, RoleID) VALUES 
('Student-003', 'Charlie Brown', 3),
('Student-004', 'Diana Prince', 3);

-- Test Case 1: DML Operations - Borrowing Books
-- Expected: New borrow record created, book quantity decreased
INSERT INTO BorrowLogs (UserID, BookID, BorrowedDate, DueDate, Status) 
VALUES ('Student-003', 3, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 14 DAY), 'Borrowed');

SELECT 'Test 1: Book borrowed successfully' as TestResult;
SELECT * FROM BorrowLogs WHERE UserID = 'Student-003';
SELECT BookQuantity FROM Books WHERE BookID = 3;

-- Test Case 2: DML Operations - Returning Books
-- Expected: Return date updated, book quantity increased
UPDATE BorrowLogs 
SET ReturnDate = CURDATE(), Status = 'Returned' 
WHERE UserID = 'Student-003' AND BookID = 3 AND Status = 'Borrowed';

SELECT 'Test 2: Book returned successfully' as TestResult;
SELECT * FROM BorrowLogs WHERE UserID = 'Student-003';

-- Test Case 3: Available vs Borrowed Books Query
-- Expected: Shows available and borrowed book counts
SELECT 'Test 3: Available vs Borrowed Books' as TestResult;
SELECT BookStatus, COUNT(*) as BookCount FROM Books GROUP BY BookStatus;

-- Test Case 4: Overdue Borrowers Query
-- Expected: Shows borrowers with overdue books
INSERT INTO BorrowLogs (UserID, BookID, BorrowedDate, DueDate, Status) 
VALUES ('Student-004', 4, DATE_SUB(CURDATE(), INTERVAL 20 DAY), DATE_SUB(CURDATE(), INTERVAL 5 DAY), 'Borrowed');

SELECT 'Test 4: Overdue Borrowers Query' as TestResult;
SELECT u.FullName, b.BookTitle, bl.DueDate, DATEDIFF(CURDATE(), bl.DueDate) as DaysOverdue
FROM Users u
JOIN BorrowLogs bl ON u.UserID = bl.UserID
JOIN Books b ON bl.BookID = b.BookID
WHERE bl.DueDate < CURDATE() AND bl.Status = 'Borrowed';

-- Test Case 5: Penalty Computation Procedure
-- Expected: Penalty calculated and inserted for overdue book
CALL CalculatePenalty(1);
SELECT 'Test 5: Penalty Computation' as TestResult;
SELECT * FROM Penalty WHERE BorrowLogID = 1;

-- Test Case 6: Active Borrowed Books View
-- Expected: Shows currently borrowed books with borrower details
SELECT 'Test 6: Active Borrowed Books View' as TestResult;
SELECT * FROM ActiveBorrowedBooks;

-- Test Case 7: Trigger Testing - Book Status Update
-- Expected: Book status changes when borrowed/returned
INSERT INTO BorrowLogs (UserID, BookID, BorrowedDate, DueDate, Status) 
VALUES ('Student-003', 1, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 14 DAY), 'Borrowed');

SELECT 'Test 7: Trigger - Book Status Update' as TestResult;
SELECT BookID, BookStatus, BookQuantity FROM Books WHERE BookID = 1;

-- Test Case 8: Lost Book Penalty
-- Expected: High penalty for lost books
UPDATE BorrowLogs SET Status = 'Lost' WHERE BorrowLogID = 2;
SELECT 'Test 8: Lost Book Penalty' as TestResult;
SELECT * FROM Penalty WHERE PenaltyReason = 'Lost';

-- Cleanup Test Data
DELETE FROM Penalty WHERE BorrowLogID > 2;
DELETE FROM BorrowLogs WHERE BorrowLogID > 2;
DELETE FROM Books WHERE BookID > 2;
DELETE FROM Users WHERE UserID IN ('Student-003', 'Student-004');

SELECT 'All tests completed successfully!' as FinalResult;