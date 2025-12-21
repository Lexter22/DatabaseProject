-- Import/Export: Excel Book Inventory Operations
-- Author: Database Team
-- Description: Scripts for importing/exporting book data to/from Excel

USE LibrarySystem;

-- Export books to CSV (can be opened in Excel)
SELECT BookID, BookTitle, BookAuthor, PublishedYear, BookGenre, BookQuantity, BookStatus, BookDescription
INTO OUTFILE '/tmp/books_export.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM Books;

-- Import books from CSV
LOAD DATA INFILE '/tmp/books_import.csv'
INTO TABLE Books
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(BookTitle, BookAuthor, PublishedYear, BookDescription, BookQuantity, @status, BookGenre)
SET BookStatus = @status;

-- Alternative: Export with headers
SELECT 'BookID', 'BookTitle', 'BookAuthor', 'PublishedYear', 'BookGenre', 'BookQuantity', 'BookStatus', 'BookDescription'
UNION ALL
SELECT BookID, BookTitle, BookAuthor, PublishedYear, BookGenre, BookQuantity, BookStatus, BookDescription
FROM Books
INTO OUTFILE '/tmp/books_with_headers.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

-- Note: Adjust file paths based on your system
-- For Windows: Use 'C:\\temp\\books_export.csv'
-- For macOS/Linux: Use '/tmp/books_export.csv'
-- Ensure MySQL has file permissions: SET GLOBAL local_infile = 1;