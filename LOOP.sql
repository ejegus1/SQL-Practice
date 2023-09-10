--------------------------------------------------------------
/*		    Procedural Language Control Structures          */
--------------------------------------------------------------

--  The WHILE Loop

    /*
        General Form of the WHILE Loop:

            [ <<label>> ]
            WHILE boolean-expression LOOP
                statements
            END LOOP [ label ];

        Two Simple Examples:

            WHILE num1 > 0 AND num2 > 0 LOOP
                -- Multiple Computations Here
            END LOOP;

            <<loopName>>
            WHILE NOT done LOOP
                -- Multiple Computations Here
            END LOOP loopName;
    */

    --  Below is a toy example of a WHILE loop

	CREATE OR REPLACE FUNCTION test_func(num INTEGER)        -- take in some number num--
	RETURNS INTEGER
	LANGUAGE plpgsql
	AS
	$$
	
	   DECLARE
	   		x INTEGER;          -- declring variable x to be an integer--
	   BEGIN
	   		x:=0;           --- x is intially equal to 0 
			
			<<whileloop>>       --- naming convention
			WHILE (num < 10) LOOP      ---we are going to iterate while loop as long as num is less than 10--
				x:= x + 1;               ---this will be execured everytime the while loop iterates-- 
				num := num + 1;
			END LOOP whileloop;
			RETURN x;                  --returing however x has changed--
	   END;
	
	$$;
    --  This function can be invoked by the following SELECT statement:
	
	SELECT test_func(2);



--  The Integer Variant For Loop

    /*
        General Form of the Integer Variant For Loop:

            [ <<label>> ]
            FOR name IN [ REVERSE ] exprs .. exprs [ BY exprs ] LOOP
            -- Multiple Statements Here
            END LOOP [ label ];

        Three Simple Examples:

            FOR i IN 1..10 LOOP
                -- i will take on values 1,2,3,4,5,6,7,8,9,10 within the loop
            END LOOP;

            FOR i IN REVERSE 10..1 LOOP
                -- i will take on values 10,9,8,7,6,5,4,3,2,1 within the loop
            END LOOP;

            FOR i IN REVERSE 10..1 BY 2 LOOP
                -- i will take on values 10,8,6,4,2 within the loop
            END LOOP;
    */

        --  Below is a toy example of a IF loop

		CREATE OR REPLACE FUNCTION test_func_for(num INTEGER)
		RETURNS INTEGER
		LANGUAGE plpgsql
		AS
		$$
			DECLARE 
			   x INTEGER;
			BEGIN 
				X:=0;
				
				<<forloop>>
				
				FOR loopindex IN num .. 9 LOOP
				X := X+1;
				
				END LOOP forloop;
				
				RETURN X;
			END;
		
		$$;

    --  This function can be invoked by the following SELECT statement:

	SELECT test_func_for(2);

--  The Record Variant For Loop

    /*
        General Form of the Integer Variant For Loop:

            [ <<label>> ]
            FOR target IN query LOOP
                statements
            END LOOP [ label ];
    */

    /*  As an example of a for loop that iterates over individual tuples returned from a
        query, consider the following example.  Suppose we wish to find the total amount of
        money budgeted towards all departments in the university.  We could write the following
        query to accomplish this:   */

	SELECT SUM(budget) AS budget_total
	FROM department;

    --  We could, albeit more complicatedly, write a function to accomplish the same task as:
	
		CREATE OR REPLACE FUNCTION sum_dept_budget()
		RETURNS NUMERIC
		LANGUAGE plpgsql
		AS
		$$
			DECLARE 
			   total NUMERIC(12,2);
			   tuple RECORD;
			BEGIN 
				total := 0.00;
				
				FOR tuple IN (SELECT * FROM department) LOOP
					total := total + tuple.budget;
				END LOOP;
				
				RETURN total;
			END;
		
		$$;

	DROP FUNCTION sum_dept_budget();


    /*  We could invoke the following function using the below syntax to obtain the exact
        same result as the SELECT-FROM statement seen earlier.      */

	SELECT sum_dept_budget() AS budget_total;

--  The IF-THEN-ELSIF Conditional

/*
    General Form of the IF-THEN-ELSIF Conditional:

        IF boolean-expression THEN
            statements
        [ ELSIF boolean-expression THEN
            statements
        [ ELSIF boolean-expression THEN
            statements
        ...]]
        [ ELSE
            statements ]
        END IF;