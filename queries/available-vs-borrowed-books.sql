-- Query: Available vs Borrowed Books
-- Author: Database Team
-- Description: Show books that are available vs currently borrowed

USE LibrarySystem;

-- Query for available books
SELECT BookID, BookTitle, BookAuthor, BookQuantity, BookStatus 
FROM Books 
WHERE BookStatus = 'Available';

-- Query for borrowed books (currently not returned)
SELECT b.BookID, b.BookTitle, b.BookAuthor, bl.UserID, bl.BorrowedDate, bl.DueDate
FROM Books b 
JOIN BorrowLogs bl ON b.BookID = bl.BookID 
WHERE bl.Status = 'Borrowed';

-- Combined query showing both available and borrowed counts
SELECT 
    BookStatus,
    COUNT(*) as BookCount
FROM Books 
GROUP BY BookStatus;