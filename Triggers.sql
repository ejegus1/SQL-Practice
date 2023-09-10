--------------------------------------------------------------
/*                        Triggers                          */
--------------------------------------------------------------

/*  A trigger is a statement that the system executes automatically as a side effect of a
    modification to the database.  To define a trigger, we must:

    1)  Specify when a trigger is to be executed.  This is broken up into an event that causes
        the trigger to be checked and a condition that must be satisfied for the trigger execution to proceed.

    2)  Specify the actions to be taken when the trigger executes.

    Once we enter a trigger into the database, the database system takes on the responsibility of
    executing it whenever the specified event occurs and the corresponding condition is satisfied.  */

--  Trigger Functions

    /*  To create a trigger in PostgreSQL, we must begin by creating a trigger function.
        A trigger function is similar to a regular user-defined function, but a trigger
        function does not take any arguments as input and has a return value with the type “trigger”.

        General Form of a Trigger Function:

        CREATE FUNCTION trigger_function_name()
        RETURNS TRIGGER
        LANGUAGE PLPGSQL
        AS
        $$
            BEGIN
               -- trigger logic
            END;
        $$;
    */

--  The CREATE TRIGGER Statement

    /*  The general form of a trigger in PostgreSQL is given by the following syntax:

    CREATE [CONSTRAINT] TRIGGER name {BEFORE|AFTER|INSTEAD OF}
    { event [ OR ... ] }
        ON table
        [ FROM referenced_table_name ]
        [ NOT DEFERRABLE | [ DEFERRABLE ] { INITIALLY IMMEDIATE |
    INITIALLY DEFERRED } ]
        [ FOR [ EACH ] { ROW | STATEMENT } ]
        [ WHEN ( condition ) ]
        EXECUTE PROCEDURE function_name ( arguments )

    where event can be one of:

        INSERT
        UPDATE [ OF column_name [, ... ] ]
        DELETE
        TRUNCATE

    */

    /*  As an example, we will design a trigger that, whenever a tuple is inserted into the takes
        relation, updates the tuple in the student relation for the student taking the course by
        adding the number of credits for the course to the student’s total credits.     */

        --  Below is the trigger function:
	
		CREATE OR REPLACE FUNCTION addCourseCredit()                  --trigger functions do not take any imput arguments
		RETURNS TRIGGER
		LANGUAGE plpgsql
		AS
		$$
			DECLARE
				courseCredits NUMERIC(2,0);
			BEGIN
				SELECT credits INTO courseCredits
				FROM course
				WHERE course_id = NEW.course_id;
				
				UPDATE student
				SET tot_cred = tot_cred + courseCredits
				WHERE id = NEW.id;
				
				RETURN NEW;
			END;
		
		$$;

    --  The trigger is given by:
	
	CREATE TRIGGER UpdateTotCredTrigger
	AFTER INSERT ON takes
	FOR EACH ROW
	WHEN ((NEW.grade NOT LIKE '%F%') AND (NEW.grade IS NOT NULL))
	EXECUTE PROCEDURE addCourseCredit();


    --  We can first view the value of the tot_credits attribute that the student Keanu Reeves has:

	SELECT *
	FROM student 
	WHERE name LIKE '%Keanu%';

    /*  Next, we will suppose that Keanu successfully completed two courses, and we will
        insert their associated tuples into the takes relation.     */
		
		INSERT INTO takes
		VALUES('96385', '313', '1', 'Fall', 2010, 'B');
		
		INSERT INTO takes
		VALUES('96385', '443', '1', 'Spring', 2010, 'A-');



    /*  Lastly, we can verify that the trigger worked properly by checking the total number
        of credits that Keanu has, and confirming its increase.     */
		
		SELECT tot_cred
		FROM student 
		WHERE name like '%Keanu%';   -- invcrease of 7 credits