--------------------------------------------------------------
/*		                  Transactions           		    */
--------------------------------------------------------------

--  Transactions

    /*  General Form:
            BEGIN               BEGIN
            ...         or      ...
            COMMIT              ROLLBACK
    */

    --  Simple Transaction Examples
	
		BEGIN;
		     INSERT INTO student
			 VALUES ('36925', 'Georgie', 'Comp. Sci.', 6);
	    COMMIT;
			
		
		SELECT * 
		FROM student
		WHERE name = 'Georgie';
		
		BEGIN;
		    DELETE FROM student
			WHERE student.name = 'Georgie';
		ROLLBACK;
		
	BEGIN;
		    DELETE FROM student
			WHERE student.name = 'Georgie';
	 COMMIT;
	
		
    --  Transactions: Banking Example

        /*  Note the following two queries will not execute in the database,
            unless you create the DDL for them.     */

                BEGIN;
                    UPDATE accounts SET balance = balance - 100.00
                        WHERE name = 'Alice';
                    UPDATE branches SET balance = balance - 100.00
                        WHERE name = (SELECT branch_name FROM accounts WHERE name = 'Alice');
                    UPDATE accounts SET balance = balance + 100.00
                        WHERE name = 'Bob';
                    UPDATE branches SET balance = balance + 100.00
                        WHERE name = (SELECT branch_name FROM accounts WHERE name = 'Bob');
                COMMIT;

        /*  PostgreSQL actually treats every SQL statement as being executed within a transaction.
            If you do not issue a BEGIN command, then each individual statement has an
            implicit BEGIN and (if successful) COMMIT wrapped around it. A group of statements surrounded
            by BEGIN and COMMIT is sometimes called a transaction block.    */

        /*  Suppose we debit $100.00 from Alice's account, and credit Bob's account,
            but realize that we should have credited Wally's account.
            We could do fix our mistake using savepoints like this:     */

                BEGIN;
                    UPDATE accounts SET balance = balance - 100.00
                        WHERE name = 'Alice';

                    SAVEPOINT my_savepoint; -- save current state of the database (after debtiing alice's account for 100.00)

                    UPDATE accounts SET balance = balance + 100.00
                        WHERE name = 'Bob';
                    -- oops ... forget that and use Wally's account

                    ROLLBACK TO my_savepoint;

                    UPDATE accounts SET balance = balance + 100.00
                        WHERE name = 'Wally';
                COMMIT;