/*
    Name: Ejegu Smith
    DTSC660: Data and Database Managment with SQL
    Assignment 5
*/

--------------------------------------------------------------------------------
/*				                 Banking DDL           		  		          */
--------------------------------------------------------------------------------

        CREATE TABLE branch (
			branch_name VARCHAR(30),
			branch_city VARCHAR(40),
			assets 	 NUMERIC(12,2),
			 CONSTRAINT branch_pkey PRIMARY KEY(branch_name)
		);
		
		 CREATE TABLE customer (
			ID VARCHAR(5),
			customer_name VARCHAR(30) NOT NULL,
			customer_street VARCHAR(20),
			customer_city   VARCHAR(40),
			 CONSTRAINT customer_pkey PRIMARY KEY(ID)
		);
		
		
 
 
 CREATE TABLE loan (
			loan_number VARCHAR(12) ,
			 branch_name VARCHAR(30),
			 amount NUMERIC(12,2) CONSTRAINT positiveAmount CHECK(amount > 0.00),
			 CONSTRAINT loan_pkey PRIMARY KEY(loan_number),
	 		CONSTRAINT loan_fkey FOREIGN KEY (branch_name) REFERENCES branch (branch_name) ON DELETE CASCADE
		);
		
	CREATE TABLE borrower (
			ID VARCHAR(5),
			loan_number VARCHAR(12),
			 CONSTRAINT borrower_pkey PRIMARY KEY(ID, loan_number),
		     CONSTRAINT account_fkey FOREIGN KEY (ID) REFERENCES customer (ID) ON UPDATE CASCADE
	 		
		);
		
		CREATE TABLE account (
			account_number VARCHAR(12),
			 branch_name VARCHAR(30),
			 balance NUMERIC(12,2) CONSTRAINT positiveBalance CHECK(balance > 0.00),
			 CONSTRAINT account_pkey PRIMARY KEY(account_number),
	 		CONSTRAINT account_fkey FOREIGN KEY (branch_name) REFERENCES branch (branch_name) ON UPDATE CASCADE
		);
		
		CREATE TABLE depositor (
			 ID VARCHAR(5) NOT NULL,
			 account_number VARCHAR(12),
			 CONSTRAINT depositor_pkey PRIMARY KEY(ID, account_number),
			CONSTRAINT depositor_fkey FOREIGN KEY (ID) REFERENCES customer (ID) ON UPDATE CASCADE

		);


--------------------------------------------------------------------------------
/*				                  Question 1           		  		          */
--------------------------------------------------------------------------------

   
   CREATE OR REPLACE FUNCTION smith_21_monthlyPayment(PRT NUMERIC(12,2), APR DEC(6,0), year INTEGER)
		RETURNS NUMERIC(12,2)
		LANGUAGE plpgsql
		AS
		$$
			DECLARE
				     smith_21_monthlyPayment NUMERIC(12,2);
			BEGIN
				SELECT PRT *(APR + (APR/(POWER(1 + APR, year*12) -1)) INTO smith_21_monthlyPayment

				RETURN smith_21_monthlyPayment;
			END;
			
		$$;
   
   
   

--------------------------------------------------------------------------------
/*				                  Question 2           		  		          */
--------------------------------------------------------------------------------

    ------------------------------- Part (a) ------------------------------
      
 /*Write a query to find the ID and customer name of each customer at the bank who only
has a loan at the bank, and no account */

        SELECT c.id, customer_name
		FROM branch as b
		FULL JOIN account as a
		ON b.branch_name = a.branch_name
		FULL JOIN depositor as d
		ON d.account_number = a.account_number
	    FULL JOIN customer as c
		ON c.id = d.id
		FULL JOIN loan as l
		ON b.branch_name = l.branch_name
		WHERE a.account_number IS NULL
		AND loan_number IS NOT NULL;
	 	
    ------------------------------- Part (b) ------------------------------
/* Write a query to find the ID and customer name of each customer who lives on the same
street and in the same city as customer ‘12345’.*/


  SELECT ID, customer_name
  FROM customer
  WHERE customer_street IN (select customer_street FROM customer where id = '12345')
  AND customer_city IN (select customer_city FROM customer where id = '12345');
  
	                                         



   ------------------------------- Part (c) ------------------------------
  /*Write a query to find the name of each branch that has at least one customer who has an
account in the bank and who lives in “Harrison”.*/
		
		SELECT b.branch_name
		FROM branch as b
		JOIN account as a
		ON b.branch_name = a.branch_name
		JOIN depositor as d
		ON d.account_number = a.account_number
	    JOIN customer as c
		ON c.id = d.id
		WHERE customer_city = 'Harrison';
		
		
		
		

    ------------------------------- Part (d) ------------------------------
      /*Write a query to find each customer who has an account at every branch located in
“Brooklyn”*/

        SELECT *
		FROM branch as b
		JOIN account as a
		ON b.branch_name = a.branch_name
		JOIN depositor as d
		ON d.account_number = a.account_number
	    JOIN customer as c
		ON c.id = d.id
		WHERE b.branch_name = 'Brooklyn Bridge Bank'
		AND b.branch_name = 'Brooklyn Bank'
		AND b.branch_name = 'First Bank of Brooklyn';
	
		
--------------------------------------------------------------------------------
/*				                  Question 3           		  		          */
--------------------------------------------------------------------------------

/*Consider the given bank database schema given in question (2). Write a SQL trigger to
carry out the following action: On delete of an account, for each customer-owner of the
account, check if the owner has any remaining accounts, and if she does not, delete her
from the depositor relation. You must submit both your trigger function definition, and
your trigger definition.*/

smith_21_bankTriggerFunction()
smith_21_bankTrigger

							 
                --trigger functions do not 
			CREATE OR REPLACE FUNCTION smith_21_bankTriggerFunction()                  --trigger functions do not take any imput arguments
		RETURNS TRIGGER
		LANGUAGE plpgsql
		AS
		$$
			DECLARE
				bk NUMERIC(2,0);
			BEGIN
				
				
				RETURN NEW;
			END;
		
		$$;
												 										 
		
							 
	   
	    CREATE TRIGGER smith_21_bankTrigger
		AFTER DELETE ON account
		REFERENCING OLD ROW oldr
	    FOR EACH STATEMENT DELETE FROM depositor
	    WHERE depositor.id NOT IN
			(SELECT depositor.id FROM depositor
			 WHERE account_number <> oldr.account_number)
		EXECUTE PROCEDURE smith_21_bankTriggerFunction();
							 
							 

--------------------------------------------------------------------------------
/*				                  Question 4           		  		          */
--------------------------------------------------------------------------------
/*For this problem create a (temporary) table called instructor_course_nums. Write a
procedure that accepts an instructor ID as input. The procedure calculates the total
number of course sections taught by that instructor, and adds a tuple to the temporary
table consisting of the instructors ID number, name, and total courses taught - call these
attributes: ID, name, and tot_courses. If the instructor already has an entry in the table,
then the procedure makes sure the total number of courses taught in the temporary table
is up-to-date.*/
							 
		CREATE TABLE instructor_course_nums(
		              ID VARCHAR(5),
			          name VARCHAR(30),
					  tot_courses INTEGER);
							 
					
		CREATE OR REPLACE PROCEDURE smith_21_insCourseNumsProc(IN ID VARCHAR(5), INOUT sec_count INTEGER)
			LANGUAGE plpgsql
			AS 
			$$
			  	BEGIN
					SELECT COUNT(s.sec_id), i.ID INTO sec_count
				 	FROM instructor as i
				 	JOIN teaches as t
				 	ON i.id = t.id
				 	JOIN section as s
				 	ON t.course_id = s.course_id
				 	WHERE i.ID = instructor_course_nums.ID
				 	GROUP BY i.ID;

				 END;

			$$;
							 
			
	CALL smith_21_insCourseNumsProc('4233', 0);
							 
							 
							 SELECT ID 
							 FROM INSTRUCTOR
							 
							SELECT *
							 FROM instructor_course_nums
			
							  