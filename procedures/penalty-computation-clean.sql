-- Stored Procedure: Penalty Computation
-- Author: Database Team
-- Description: Calculate and insert penalties for overdue/lost books

USE LibrarySystem;

DELIMITER //

CREATE PROCEDURE CalculatePenalty(IN p_BorrowLogID INT)
BEGIN
    DECLARE v_dueDate DATE;
    DECLARE v_returnDate DATE;
    DECLARE v_status VARCHAR(20);
    DECLARE v_daysOverdue INT DEFAULT 0;
    DECLARE v_penaltyAmount DECIMAL(10,2) DEFAULT 0.00;
    DECLARE v_penaltyReason VARCHAR(20);

    DECLARE v_borrowerName VARCHAR(150);
    DECLARE v_bookTitle VARCHAR(150);
    
    SELECT 
        bl.DueDate,
        bl.ReturnDate,
        bl.Status,
        u.FullName,
        b.BookTitle
    INTO
        v_dueDate,
        v_returnDate,
        v_status,
        v_borrowerName,
        v_bookTitle
    FROM BorrowLogs bl
    JOIN Users u 
        ON bl.UserID = u.UserID
    JOIN Books b 
        ON bl.BookID = b.BookID
    WHERE bl.BorrowLogID = p_BorrowLogID
    LIMIT 1;

	/* Penalty Computation */
    IF v_status = 'Lost' THEN
        SET v_penaltyAmount = 500.00;
        SET v_penaltyReason = 'Lost';
        SET v_daysOverdue = 0;

    ELSEIF v_status = 'Returned'
        AND v_returnDate IS NOT NULL
        AND v_returnDate > v_dueDate THEN

        SET v_daysOverdue = DATEDIFF(v_returnDate, v_dueDate);
        SET v_penaltyAmount = v_daysOverdue * 10.00;
        SET v_penaltyReason = 'Overdue';

    ELSE
        SET v_penaltyAmount = 0.00;
        SET v_penaltyReason = 'No Penalty';
        SET v_daysOverdue = 0;
    END IF;

    /* Displaying Results */
    SELECT
        p_BorrowLogID   AS BorrowLogID,
        v_borrowerName  AS BorrowerName,
        v_bookTitle     AS BookTitle,
        v_status        AS Status,
        v_dueDate       AS DueDate,
        v_returnDate    AS ReturnDate,
        v_daysOverdue   AS DaysOverdue,
        v_penaltyAmount AS PenaltyAmount,
        v_penaltyReason AS PenaltyReason;

END

DELIMITER ;

-- Test the procedure
CALL CalculatePenalty(1);