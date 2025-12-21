-- Trigger: Update Book Status and Penalty
-- Author: Database Team
-- Description: Automatically update book status and calculate penalties

USE LibrarySystem;

DELIMITER //

-- Trigger for book status update when borrowing
CREATE TRIGGER UpdateBookStatusOnBorrow
AFTER INSERT ON BorrowLogs
FOR EACH ROW
BEGIN
    IF NEW.Status = 'Borrowed' THEN
        UPDATE Books 
        SET BookStatus = 'Unavailable', BookQuantity = BookQuantity - 1 
        WHERE BookID = NEW.BookID;
    END IF;
END //

-- Trigger for penalty calculation on return
CREATE TRIGGER CalculatePenaltyOnReturn
AFTER UPDATE ON BorrowLogs
FOR EACH ROW
BEGIN
    DECLARE v_daysOverdue INT DEFAULT 0;
    DECLARE v_penaltyAmount DECIMAL(8,2) DEFAULT 0.00;
    
    IF NEW.Status = 'Returned' AND OLD.Status = 'Borrowed' THEN
        -- Update book status back to available
        UPDATE Books 
        SET BookStatus = 'Available', BookQuantity = BookQuantity + 1 
        WHERE BookID = NEW.BookID;
        
        -- Calculate penalty if returned late
        IF NEW.ReturnDate > NEW.DueDate THEN
            SET v_daysOverdue = DATEDIFF(NEW.ReturnDate, NEW.DueDate);
            SET v_penaltyAmount = v_daysOverdue * 10.00;
            
            INSERT INTO Penalty (BorrowLogID, ReturnDate, DueDate, BorrowedID, DaysOverdue, PenaltyAmount, PenaltyReason)
            VALUES (NEW.BorrowLogID, NEW.ReturnDate, NEW.DueDate, NEW.BorrowLogID, v_daysOverdue, v_penaltyAmount, 'Overdue');
        END IF;
    END IF;
    
    -- Handle lost books
    IF NEW.Status = 'Lost' AND OLD.Status != 'Lost' THEN
        INSERT INTO Penalty (BorrowLogID, ReturnDate, DueDate, BorrowedID, DaysOverdue, PenaltyAmount, PenaltyReason)
        VALUES (NEW.BorrowLogID, NULL, NEW.DueDate, NEW.BorrowLogID, 0, 500.00, 'Lost');
    END IF;
END //

DELIMITER ;

-- Test triggers by inserting/updating BorrowLogs
INSERT INTO BorrowLogs (UserID, BookID, BorrowedDate, DueDate, Status) 
VALUES ('Student-001', 1, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 14 DAY), 'Borrowed');