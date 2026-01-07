-- ========================================
-- 7. VIEW: Active Borrowed Books Summary
-- ========================================
-- This view displays all currently borrowed books with borrower information,
-- book details, due dates, and penalty information for overdue books.

CREATE VIEW ActiveBorrowedBooksSummary AS
SELECT 
    bl.BorrowLogID AS BorrowID,
    u.UserID AS BorrowerID,
    u.FullName AS BorrowerName,
    r.Role AS UserRole,
    b.BookID AS BookID,
    b.BookTitle AS BookTitle,
    b.BookAuthor AS BookAuthor,
    b.BookGenre AS Genre,
    bl.BorrowedDate AS BorrowedDate,
    bl.DueDate AS DueDate,
    bl.Status AS BorrowStatus,
    CASE 
        WHEN bl.Status = 'Borrowed' AND bl.DueDate < CURDATE() THEN 'OVERDUE'
        WHEN bl.Status = 'Borrowed' AND bl.DueDate >= CURDATE() THEN 'ACTIVE'
        WHEN bl.Status = 'Lost' THEN 'MISSING'
        ELSE UPPER(bl.Status)
    END AS BookStatus,
    CASE
        WHEN bl.DueDate < CURDATE() THEN DATEDIFF(CURDATE(), bl.DueDate)
        ELSE 0
    END AS DaysOverdue,
    COALESCE(p.PenaltyAmount, 0.00) AS PenaltyAmount,
    COALESCE(p.PenaltyReason, 'None') AS PenaltyReason,
    b.BookQuantity AS AvailableBookQuantity
FROM 
    BorrowLogs bl
    INNER JOIN Users u ON bl.UserID = u.UserID
    INNER JOIN Roles r ON u.RoleID = r.RoleID
    INNER JOIN Books b ON bl.BookID = b.BookID
    LEFT JOIN Penalty p ON bl.BorrowLogID = p.BorrowLogID
WHERE 
    bl.Status = 'Borrowed' OR bl.Status = 'Lost';
