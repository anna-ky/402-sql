--NAME: Anna Sam
--CWID: 888304771

/************ QUESTION 01 ************
Difficulty: Easy
  Question: What are the two categories of books?
    Answer: Fiction and Nonfiction 
**************************************/
SELECT CategoryName
FROM Category;


/************ QUESTION 02 ************
Difficulty: Easy
  Question: How many books did Dr. Soper read between 2006 and 2020?
    Answer: 1,025
**************************************/
SELECT COUNT (*) AS books_between_2006_and_2020
FROM BookRead
WHERE yearRead >= 2006 AND yearRead <= 2020;


/************ QUESTION 03 ************
Difficulty: Easy
  Question: Which subcategory names begin with "20th Century"? Your answer should be ordered alphabetically.
    Answer: 20th Century American, 20th Century British, 20th Century Canadian, 20th Century German,
            20th Century Irish, 20th Century Russian, and 20th Century Taiwanese
**************************************/
SELECT subcategoryName
FROM subcategory
WHERE subcategoryName LIKE '20th Century%'
ORDER BY subcategoryName;


/************ QUESTION 04 ************
Difficulty: Easy
  Question: How many unique authors are there?
    Answer: 649
**************************************/
SELECT COUNT (*) AS unique_authors
FROM Author;


/************ QUESTION 05 ************
Difficulty: Easy
  Question: What is the title and number of pages of the shortest book that Dr. Soper has read?
       TIP: You can use the "SELECT TOP n" syntax to fetch just the first n rows in the result set.
	        See the following URL for an example: https://www.w3schools.com/sqL/trysql.asp?filename=trysql_select_top&ss=-1
    Answer: "The Abolition of Man", 60 pages
**************************************/
SELECT TOP 1 title, pages
FROM book
ORDER BY pages;


/************ QUESTION 06 ************
Difficulty: Easy
  Question: What is the title of the only book in Dr. Soper's reading list that is exactly 583 pages long?
    Answer: The Da Vinci Code
**************************************/
SELECT title
FROM book
WHERE pages = 583;


/************ QUESTION 07 ************
Difficulty: Medium
  Question: What is the title of the very first book that Dr. Soper added to his reading list?
    Answer: The Hitchhiker's Guide to the Galaxy
**************************************/
SELECT TOP 1 title 
FROM book b INNER JOIN bookRead br ON b.bookId = br.bookId 
ORDER BY readingOrder; 


/************ QUESTION 08 ************
Difficulty: Medium
  Question: In 2015, Dr. Soper read just one book that was written by multiple authors. 
            What is the title of that book?
    Answer: Think Like a Freak
**************************************/
SELECT title
FROM bookAuthor ba INNER JOIN book b ON ba.bookId = b.bookID INNER JOIN bookRead br ON b.bookID = br.bookID
WHERE br.yearRead = 2015 
GROUP BY b.title 
HAVING COUNT (*)> 1; 


/************ QUESTION 09 ************
Difficulty: Medium
  Question: In what year did Dr. Soper read the fewest total pages, and how many pages 
            did he read during that year? 
       TIP: Read about the SQL "SUM" function.
    Answer: Year = 2006, total pages read in 2006 = 2,893
**************************************/
SELECT TOP 1 yearRead, SUM(pages) AS totalPages
FROM Book b INNER JOIN bookRead br ON b.bookId = br.bookId 
GROUP BY yearRead
ORDER BY totalPages; 


/************ QUESTION 10 ************
Difficulty: Medium
  Question: How many total pages has Dr. Soper read in books written by Richard Feynman? 
       TIP: You will need to include the BookRead table in your query because Dr. Soper has 
	        read at least one of Richard Feynman's books several times.
    Answer: 2,750 pages
**************************************/
SELECT SUM(pages) AS totalPages
FROM book b INNER JOIN bookRead br ON b.bookId = br.bookId 
INNER JOIN bookAuthor ba ON ba.bookId = b.bookId 
INNER JOIN author a ON a.authorId = ba.authorId 
WHERE a.authorName = 'Richard Feynman';


/************ QUESTION 11 ************
Difficulty: Hard
  Question: What are the three most popular subcategories of nonfiction books that Dr. Soper 
            has read? Your results should contain the names of the nonfiction subcategories 
			and the number of books read within each of those subcategories.
    Answer: Biography & Autobiography (104 books), History (66 books), Science and Mathematics (51 books)
**************************************/
SELECT TOP 3 subcategoryName,
COUNT(*) AS totalBooksRead
FROM book b INNER JOIN bookRead br ON b.bookId = br.bookId 
INNER JOIN subcategory s ON b.subcategoryId = s.subcategoryId
INNER JOIN category c ON c.categoryId = s.categoryId 
WHERE c.categoryName = 'Nonfiction' 
GROUP BY subcategoryName
ORDER BY totalBooksRead DESC; 


/************ QUESTION 12 ************
Difficulty: Hard
  Question: What is the minimum number of pages, maximum number of pages, and average number of pages 
            for all of the unique books written by George R. R. Martin that Dr. Soper has read?
	   TIP: Be sure to include the BookRead table in your join, since Dr. Soper has read many of
	        George R. R. Martin's books multiple times.
    Answer: Minimum = 112 pages, maximum = 1,216 pages, average = 683 pages
**************************************/
SELECT MIN(pages) AS minPages, MAX(pages) AS maxPages, AVG(pages) AS averagePages
FROM book b INNER JOIN bookAuthor ba ON b.bookId = ba.bookId 
INNER JOIN author a ON ba.authorId = a.authorId 
INNER JOIN bookRead br ON br.bookId = b.bookId 
WHERE a.authorName = 'George R. R. Martin'; 
