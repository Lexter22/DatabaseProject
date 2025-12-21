-- DML Operations: Borrowing and Returning Books
-- Author: Database Team
-- Description: INSERT, UPDATE operations for book borrowing and returning

USE LibrarySystem;

-- Borrow a book
INSERT INTO BorrowLogs (UserID, BookID, BorrowedDate, DueDate, Status) 
VALUES ('Student-001', 1, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 14 DAY), 'Borrowed');

-- Update book quantity when borrowed
UPDATE Books SET BookQuantity = BookQuantity - 1 WHERE BookID = 1;

-- Return a book
UPDATE BorrowLogs 
SET ReturnDate = CURDATE(), Status = 'Returned' 
WHERE BorrowLogID = 1 AND Status = 'Borrowed';

-- Update book quantity when returned
UPDATE Books SET BookQuantity = BookQuantity + 1 WHERE BookID = 1;

-- Test operations
SELECT * FROM BorrowLogs;
SELECT * FROM Books;