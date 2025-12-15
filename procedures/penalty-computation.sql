-- Stored Procedure: Penalty Computation
-- Author: [Keneth James E. Rivera]
-- Description: Calculate and insert penalties for overdue/lost books

DELIMITER $$
CREATE PROCEDURE ComputePenalty(IN p_BorrowLogID INT)
BEGIN
    DECLARE var_dueDate DATE;
    DECLARE var_returnedDate DATE;
    DECLARE var_status VARCHAR(20);
    DECLARE var_userID VARCHAR(50);
    DECLARE var_daysOverdue INT DEFAULT 0;
    DECLARE var_penaltyAmount DECIMAL(10,2) DEFAULT 0;
    DECLARE var_reason VARCHAR(100) DEFAULT NULL;  
    
     -- Since borrow log ID is a parameter, this is will hande missing and not correct log ID
    IF NOT EXISTS (
        SELECT 1 
        FROM borrowlogs 
        WHERE BorrowLogID = p_BorrowLogID
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'BorrowLogID not found';
    END IF;
    
    SELECT 
        b.ReturnDate,
        b.DueDate,
        b.Status,
        b.UserID
    INTO 
        var_returnedDate,
        var_dueDate,
        var_status,
        var_userID
    FROM borrowlogs b
    WHERE b.BorrowLogID = p_BorrowLogID;

    IF var_returnedDate IS NOT NULL 
       AND var_returnedDate > var_dueDate THEN
        SET var_daysOverdue = DATEDIFF(var_returnedDate, var_dueDate);
        SET var_penaltyAmount = var_daysOverdue * 100;
        SET var_reason = CONCAT_WS(', ', var_reason, 'Overdue'); 
    END IF;

    IF var_status = 'Lost' THEN
        SET var_penaltyAmount = var_penaltyAmount + 5000;
        SET var_reason = CONCAT_WS(', ', var_reason, 'Lost');  
    END IF;

    IF var_status = 'Damaged' THEN
        SET var_penaltyAmount = var_penaltyAmount + 1000;
        SET var_reason = CONCAT_WS(', ', var_reason, 'Damaged');
    END IF;

    IF var_penaltyAmount > 0 THEN
        INSERT INTO penalty (
            BorrowLogID,
            ReturnDate,
            DueDate,
            BorrowedID,
            DaysOverdue,
            PenaltyAmount,
            PenaltyReason
        )
        SELECT
            b.BorrowLogID,
            b.ReturnDate,
            b.DueDate,
            b.BookID,             
            var_daysOverdue,
            var_penaltyAmount,
            var_reason           
        FROM borrowlogs b
        WHERE b.BorrowLogID = p_BorrowLogID;
    END IF;

    -- SELECT 
    --     log.BorrowLogID,
    --     u.FullName,
    --     b.BookTitle,
    --     NULLIF(TRIM(v.PenaltyReason), '') AS PenaltyType,
    --     v.DaysOverdue,
    --     v.TotalPenalty
    -- FROM borrowlogs log 
    -- LEFT JOIN users u ON log.UserID = u.UserID
    -- LEFT JOIN books b ON log.BookID = b.BookID
    -- JOIN (
    -- 	SELECT 
    --         var_daysOverdue AS DaysOverdue,
    --         var_penaltyAmount AS TotalPenalty,
    --         var_reason AS PenaltyReason
	-- ) AS v
    -- WHERE log.BorrowLogID = p_BorrowLogID;

END$$
DELIMITER ;

-- TODO: Create procedure for penalty computation
-- CREATE PROCEDURE CalculatePenalty(IN borrowLogID INT)
-- BEGIN
--     DECLARE days_overdue INT DEFAULT 0;
--     DECLARE penalty_amount DECIMAL(8,2) DEFAULT 0.00;
--     
--     -- Calculate days overdue
--     -- Insert penalty record
--     -- Update penalty table
-- END //



-- Test the procedure
-- CALL CalculatePenalty(1);