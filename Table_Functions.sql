--------------------------------------------------------------
/*		            Table Functions in SQL                  */
--------------------------------------------------------------

/*
    The SQL standard supports functions that can return a table as a result of
    calling the function; such functions are called table functions.

    In general, table-valued functions can be thought of as parameterized views
    that generalize the regular notion of views by allowing parameters.

    Below is a simplified version of the syntax for a table function:

        CREATE OR REPLACE FUNCTION <function_name>(<param_1> <paramType_1>, ...)
        RETURNS TABLE (<param_A> <paramType_A>, ...)
        LANGUAGE plpgsql
        AS
        $$
            -- Variable Declarations
            DECLARE
            	<...>
            -- SQL Statements
            BEGINaxa
            	RETURN QUERY
            <...>
            END;
        $$;
*/

/*
    The following function accepts a department name as input and returns a
    table containing all the instructors of that particular department.

    Note that we need to include the phrase RETURN QUERY in order to return the
    results of the query defined afterwards.
*/

    CREATE OR REPLACE FUNCTION instructor_of(dept_name VARCHAR(20))
        RETURNS TABLE (IDD VARCHAR(5),
					    namee VARCHAR(20),
					    dept_namee VARCHAR(20),
					    salaryy NUMERIC(8,2))
        LANGUAGE plpgsql
        AS
        $$
           
           -- SQL Statements
            BEGIN
            	RETURN QUERY
            SELECT id, name, instructor.dept_name, salary
			FROM instructor
			WHERE instructor.dept_name = instructor_of.dept_name;
            END;
        $$;     

/*  We can use the above function as follows to find all instructors in the
    Computer Science Department.    */
	
	SELECT instructor_of('Comp. Sci.'); --returns the entire rows