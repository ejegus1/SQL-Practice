--------------------------------------------------------------
/*		                View Relations           		    */
--------------------------------------------------------------

    /*
        A view is a "virtual relation" that is not explicitly stored in
        the database, but rather is defined in terms of a query and calculated
        whenever it is needed.  Views allow for certain users or groups of
        users to interact with certain subsets of data in the entire database.
    */

-- View Definition

    /*  The general form of a CREATE VIEW statement is:
        CREATE VIEW viewName AS <queryExpression>       */

    --  Example View for University Clerk:
--dont want clerk to see the salaries 
		
		CREATE VIEW faculty AS
		 SELECT id, name, dept_name
		 FROM instructor;

	/*  Query: “Create a view that lists all course sections offered by the
		Comp. Sci. department in the Spring 2004 semester with the building and
		room number of each section.”   */


            CREATE VIEW COMPSCI AS
			 SELECT course_id, sec_id
			 FROM section as s, department as d
			 WHERE s.building = d.b
			-- Drop Old View:
			-- DROP VIEW physics_fall_2017;

			-- New View Definition:


			-- Observe Data in View Relation


	--  Using Views in SQL Queries

		/*  Query: “Use the view comp_sci_spring_2004 to find all Comp. Sci. courses
			offered in the Spring 2004 semester in the Power building.”  */



		--  We can explicitly specify attribute names of a view like this:



				-- Observe Data in View Relation


		/*  One view may be used in the expression defining another view.
			For example, the following two queries are identical:

			Query: “Define a view called comp_sci_spring_2004 that lists the
			course ID and room number of all computer science courses offered in the
			Spring 2004 semester in the Power building.”         */



			--  The above query is identical to:


	/*  Materialized views are views that can be stored in the database.
		We will not consider materialzied views in this course.    */

--  Updation of View Relations

    --  Consider the following view definition and tuple insertion:
	
	    DROP VIEW faculty;
		
		CREATE VIEW faculty AS 
		SELECT ID, name, dept_name
		FROM instructor;
			
		INSERT INTO faculty 
		VALUES ('30765', 'Green', 'Music');


    /*  Two reasonable approaches to solve this insertion problem are:

        1)Reject the insertion and return an error message to the user
        2)Insert a tuple (‘30765’, ‘Green’, ‘Music’, null) into the instructor relation */

    --  Consider another view definition and tuple insertion example:

		CREATE VIEW instructor_info AS
		    SELECT ID, name, building
			FROM instructor, department
			WHERE instructor.dept_name = department.dept_name;
			
		INSERT INTO instructor_info
		VALUES ('69987', 'White', 'Taylor'); -- these insertions will not work!

    /*  A SQL view is said to be updatable (i.e. inserts, updates, or deletes
        can be applied on the view) if the following conditions are all satisfied
        by the query defining the view:

            1)  The FROM clause has only one database relation.
            2)  The SELECT clause contains only attribute names of the relation and
                does not have any expressions, aggregates, or the DISTINCT specification.
            3)  Any attribute not listed in the SELECT clause can be set to null;
                that is, it does not have a NOT NULL constraint and is not part of a primary key.
            4)  The query does not have a GROUP BY or HAVING clause.    */

    --  An example of an updatable view is:
	
		CREATE VIEW history_instructor as 
		    SELECT * 
			FROM instructor
			WHERE dept_name = 'History';