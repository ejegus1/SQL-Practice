--------------------------------------------------------------
/*						Set Operations		  				*/
--------------------------------------------------------------

-- Note: We will use the university_large database for this example.

/*	We will use the following two sets for our discussion of the UNION,
	INTERSECT, and EXCEPT operations:		*/

	--	The set of all courses taught in the Fall 2009 semester.
	-- this first query is the left set
	SELECT course_id
	FROM section
	WHERE semester = 'Fall'
	AND year = 2009



	--	The set of all courses taught in the Spring 2010 semester.
	-- this 2nd query is the right set
	SELECT course_id
	FROM section
	WHERE semester = 'Spring'
	AND year = 2010



-- The Union Operation
--union operation appends the results of the two queries and elimnates duplicate rows from its result
--union by default removes duplicates like distinct. Use 'UNION ALL' to retain duplicate entries.
	/*	Query: "Find the set of all courses taught in Fall 2009, or in Spring 2010, or in both."	*/

SELECT course_id
	FROM section
	WHERE semester = 'Fall'
	AND year = 2009
UNION
SELECT course_id
	FROM section
	WHERE semester = 'Spring'
	AND year = 2010

-- The Intersect Operation

	/*	Query: "Find the set of all courses taught in both Fall 2009 and Spring 2010."	*/
	-- INTERSECT returns all rows in results of both queries and eliminates duplicates. 'they have to be in both sets'
	
SELECT course_id
	FROM section
	WHERE semester = 'Fall'
	AND year = 2009
INTERSECT
SELECT course_id
	FROM section
	WHERE semester = 'Spring'
	AND year = 2010	
	



-- The Except Operation
--EXCEPT returns the diff between the two queries
	/*	Query: "Find the set of all courses taught in Fall 2009 but not in Spring 2010."	*/
	
SELECT course_id
	FROM section
	WHERE semester = 'Fall'
	AND year = 2009
EXCEPT
SELECT course_id
	FROM section
	WHERE semester = 'Spring'
	AND year = 2010	