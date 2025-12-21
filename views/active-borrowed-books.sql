-- View: Active Borrowed Books Summary
-- Author: Database Team
-- Description: View showing currently borrowed books with borrower details

USE LibrarySystem;

-- Create view for active borrowed books
CREATE VIEW ActiveBorrowedBooks AS
SELECT 
    u.FullName as BorrowerName,
    b.BookTitle,
    b.BookAuthor,
    bl.BorrowedDate,
    bl.DueDate,
    DATEDIFF(bl.DueDate, CURDATE()) as DaysUntilDue,
    CASE 
        WHEN DATEDIFF(bl.DueDate, CURDATE()) < 0 THEN 'Overdue'
        WHEN DATEDIFF(bl.DueDate, CURDATE()) <= 3 THEN 'Due Soon'
        ELSE 'On Time'
    END as Status
FROM BorrowLogs bl
JOIN Users u ON bl.UserID = u.UserID
JOIN Books b ON bl.BookID = b.BookID
WHERE bl.Status = 'Borrowed';

-- Test the view
SELECT * FROM ActiveBorrowedBooks;