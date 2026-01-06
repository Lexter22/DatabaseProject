-- Insert Roles
INSERT INTO Roles (Role) VALUES 
('Admin'), 
('Librarian'), 
('Student'); 

-- Insert Users (Using specific UserID formats)
-- RoleID : 
-- Admin = 1, Librarian = 2, Student = 3
INSERT INTO Users (UserID, FullName, RoleID) VALUES 
('Admin-001', 'Juan Dela Cruz', 1),
('Librarian-001', 'Maria Santos', 2),
('Student-001', 'Ana Lopez', 3),
('Student-002', 'Ramon Diaz', 3);

-- Insert Books
INSERT INTO Books (BookAuthor, BookTitle, PublishedYear, BookDescription, BookQuantity, BookStatus, BookGenre) VALUES 
('J.R.R. Tolkien', 'The Lord of the Rings', 1954, 'An epic high fantasy saga', 10, 'Available', 'High Fantasy'),
('Daniel Polansky', 'The Builders', 2015, 'A straight forward revenge novel', 3, 'Unavailable', 'Dark Fantasy'),
('J.K. Rowling', 'Harry Potter', 1997, 
'a seven-book fantasy saga following orphan Harry Potter, 
    who discovers on his eleventh birthday he is a wizard 
    and attends Hogwarts School of Witchcraft and Wizardry'
, 7, 'Available', 'Fantasy');

--  Insert BorrowLogs (Referencing the new UserIDs)
INSERT INTO BorrowLogs (UserID, BookID, BorrowedDate, DueDate, ReturnDate, Status) VALUES 
('Student-001', 1, '2025-06-21', '2025-07-10', '2025-07-22', 'Returned'), -- Late
('Student-002', 3, '2025-08-13', '2025-09-13', NULL, 'Lost'), -- Lost
('Student-002', 1, '2025-10-15', '2025-11-11', NULL, 'Borrowed');   -- Borrowed

--  Insert Penalty
INSERT INTO Penalty (BorrowLogID, ReturnDate, DueDate, BorrowedID, DaysOverdue, PenaltyAmount, PenaltyReason) VALUES 
(1, '2025-07-22', '2025-07-10', 101, 12, 120.00, 'Overdue'),
(2, NULL, '2025-09-13', 102, 0, 50.00, 'Lost');