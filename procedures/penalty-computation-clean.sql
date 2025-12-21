-- Stored Procedure: Penalty Computation
-- Author: Database Team
-- Description: Calculate and insert penalties for overdue/lost books

USE LibrarySystem;

DELIMITER //

CREATE PROCEDURE CalculatePenalty(IN borrowLogID INT)
BEGIN
    DECLARE v_dueDate DATE;
    DECLARE v_returnDate DATE;
    DECLARE v_status VARCHAR(20);
    DECLARE v_daysOverdue INT DEFAULT 0;
    DECLARE v_penaltyAmount DECIMAL(8,2) DEFAULT 0.00;
    DECLARE v_penaltyReason VARCHAR(20);
    
    -- Get borrow log details
    SELECT DueDate, ReturnDate, Status 
    INTO v_dueDate, v_returnDate, v_status
    FROM BorrowLogs 
    WHERE BorrowLogID = borrowLogID;
    
    -- Calculate penalty based on status
    IF v_status = 'Lost' THEN
        SET v_penaltyAmount = 500.00;
        SET v_penaltyReason = 'Lost';
        SET v_daysOverdue = 0;
    ELSEIF v_status = 'Returned' AND v_returnDate > v_dueDate THEN
        SET v_daysOverdue = DATEDIFF(v_returnDate, v_dueDate);
        SET v_penaltyAmount = v_daysOverdue * 10.00;
        SET v_penaltyReason = 'Overdue';
    END IF;
    
    -- Insert penalty if applicable
    IF v_penaltyAmount > 0 THEN
        INSERT INTO Penalty (BorrowLogID, ReturnDate, DueDate, BorrowedID, DaysOverdue, PenaltyAmount, PenaltyReason)
        VALUES (borrowLogID, v_returnDate, v_dueDate, borrowLogID, v_daysOverdue, v_penaltyAmount, v_penaltyReason);
    END IF;
END //

DELIMITER ;

-- Test the procedure
CALL CalculatePenalty(1);