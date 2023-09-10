--------------------------------------------------------------
/*		              Stored Procedures                     */
--------------------------------------------------------------

/*  A stored procedure is a set of user-defined precompiled SQL and procedural statements
    (declarations, assignments, loops, if-statements etc.) that are stored on the database
    server and can be invoked using the SQL interface to perform a special operation.   */

    /* Below is the general form of the CREATE PROCEDURE statement:

    CREATE [ OR REPLACE ] PROCEDURE name ( [ [ argmode ] [ argname ] argtype 
		[ { DEFAULT | = } default_expr ] [, ...] ] )
  { LANGUAGE lang_name
    | TRANSFORM { FOR TYPE type_name } [, ... ]
    | [ EXTERNAL ] SECURITY INVOKER | [ EXTERNAL ] SECURITY DEFINER
    | SET configuration_parameter { TO value | = value | FROM CURRENT }
    | AS 'definition'
    | AS 'obj_file', 'link_symbol'
    } ...                                */


    /*  The following is a simple example of creating and invoking a procedure in PostgreSQL.
        In this example, we will write a procedure that adds only one specific instructor to
        the instructor relation.  This example serves no practical purpose, but demonstrates
        that procedures are capable of performing database modifications.       */
		
		CREATE OR REPLACE PROCEDURE AddSpecificInstructor()
		LANGUAGE plpgsql
		AS 
		$$
		  BEGIN
		  	  INSERT INTO instructor(ID, name, dept_name, salary)
			  VALUES ('99999', 'Rebel', 'Comp. Sci.', 70000);
		  END;
		
		$$;

            

    --  We can invoke this procedure using the CALL keyword:
	
	CALL AddSpecificInstructor();
	

    --  We can confirm that this tuple has been added by running the following query:
	
	SELECT *
	FROM instructor
	WHERE ID = '99999';

			

    --	As another example, we can rewrite the dept_count function as a procedure in the following way:

			CREATE OR REPLACE PROCEDURE dept_count_proc(IN dept_name VARCHAR(20), INOUT d_count INTEGER)
		LANGUAGE plpgsql
		AS 
		$$
		  BEGIN
		  	 SELECT COUNT(*) INTO d_count
			 FROM instructor
			 WHERE instructor.dept_name = dept_count_proc.dept_name;
		  END;
		
		$$;

    --	We can invoke this procedure using the CALL keyword as follows:

        --	Procedure Call w/ a Placeholder (i.e. Dummy) Value for d_count
		
		CALL dept_count_proc('Comp. Sci.', 0);
			

    /*  Note that we can eliminate the need for including the dummy value in the procedure
        call by defining the procedure to have a default value for the variable d_count.  */

		CREATE OR REPLACE PROCEDURE dept_count_proc(IN dept_name VARCHAR(20), INOUT d_count INTEGER DEFAULT 0)
		LANGUAGE plpgsql
		AS 
		$$
		  BEGIN
		  	 SELECT COUNT(*) INTO d_count
			 FROM instructor
			 WHERE instructor.dept_name = dept_count_proc.dept_name;
		  END;
		
		$$;


    -- Now that we have eliminated the need for the dummy value, and we can CALL the procedure as follows.

        -- No placeholder value Needed
		
	CALL dept_count_proc('Comp. Sci.');

/*  More information about the CREATE PROCEDURE statement can be found at:
    https://www.postgresql.org/docs/11/sql-createprocedure.html     */