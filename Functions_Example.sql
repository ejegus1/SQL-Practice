--------------------------------------------------------------
/*		           Function Example in SQL                  */
--------------------------------------------------------------

/*  Suppose we want a function that accepts a department name as input, and
    returns the number of instructors in that department as output.
    The following code creates such a query:        */

		CREATE OR REPLACE FUNCTION dept_count(dept_name VARCHAR(20))
		RETURNS INTEGER 
		LANGUAGE plpgsql
		AS
		$$
			DECLARE
				d_count INTEGER;
			BEGIN
				SELECT COUNT(*) INTO d_count
				FROM instructor
				WHERE instructor.dept_name = dept_count.dept_name;
			
				RETURN d_count;
			END;
			
		$$;

/*  Note that the function’s parameter is referenced by prefixing it with the
    name of the function (i.e. dept_count.dept_name).

    The above function can be used in a query that returns names and budgets of
    all departments with at least two instructors as follows:       */

	SELECT dept_name, budget
	FROM department
	WHERE dept_count(dept_name) >= 2;
        
		
	--	Another Example
	
	SELECT dept_count('Comp. Sci.');