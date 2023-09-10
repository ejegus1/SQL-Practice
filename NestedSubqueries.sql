--------------------------------------------------------------
/*					  	Nested Subqueries		  			*/
--------------------------------------------------------------

/*	Note: WATCH OUT FOR COPYING AND PASTING! Single quotes can throw errors!	*/



-- Set Membership

	--	Query: “Find all courses taught in both the Fall 2009 and Spring 2010 semesters."
	--	Previous SQL Query Using Set Intersection
	SELECT course_id
	FROM section
	WHERE semester = 'Fall'
	AND year = 2009
	INTERSECT
	SELECT course_id
	FROM section
	WHERE semester = 'Spring'
	AND year = 2010;



		--	Same Query Rewritten Using IN Connective and Subquery
		--course ID has to be IN fall 2009 and spring 2010 
		
		SELECT DISTINCT course_id
		FROM section 
        WHERE semester = 'Fall' AND year = 2009 AND 
		      course_id IN(SELECT course_id
						  FROM section
						  WHERE semester = 'Spring'
						  AND year = 2010);


	--	Query: “Find the names of all instructors other than those named Mozart or Einstein.”
     SELECT DISTINCT name 
	 FROM instructor
	 WHERE name NOT IN(SELECT name
					    FROM instructor
					    WHERE name = 'Mozart'
					    AND name = 'Einstein');
	 


	/* 	Query: “Find the total number of (distinct) students who have taken course sections
		taught by the instructor with the ID 34175.”	*/
		
		SELECT COUNT(DISTINCT ID)
		FROM takes
		WHERE (course_id, sec_id, semester, year)
		    IN (SELECT course_id, sec_id, semester, year
			   FROM teaches
			   WHERE teaches.id = '34175');
		
			   
		
	

-- Set Comparison

/* 1) GT at least 1 in SQL is > SOME
   2) GT all is > ALL*/

	/*	SQL allows the following comparisons: < SOME, <= SOME, >= SOME, = SOME, <> SOME,
		> ALL, < ALL, <= ALL, >= ALL, = ALL, and <> ALL. 	*/

	/* 	Query: “Find the names of all instructors who salary is greater than at least
		one instructor in the Biology department.”	*/
		
		
		-- We previously wrote this SQL query as follows:
		
		SELECT DISTINCT t.name
		FROM instructor as t, instructor as s
		WHERE t.salary > s.salary and s.dept_name ='Biology';


		/*	We can rewrite this SQL query in a form that resembles English more closely
			using the SOME comparison operator:		*/
			
			SELECT name
			FROM instructor 
			WHERE salary > SOME (SELECT salary
								 FROM instructor
								 WHERE dept_name = 'Biology');
								 
		
        SELECT name
		FROM instructor 
		WHERE salary > (SELECT min(salary)
								 FROM instructor
								 WHERE dept_name = 'Biology');
  

	/*	Query: “Find the names of all instructors that have a salary value greater than
		that of each instructor in the Biology department.”		*/
		
		
		SELECT name 
		FROM instructor 
		WHERE salary > ALL (SELECT salary
					    FROM instructor
					    WHERE dept_name = 'Biology');
						
---------or------------		
		
	    SELECT name 
		FROM instructor 
		WHERE salary > (SELECT max(salary)
					    FROM instructor
					    WHERE dept_name = 'Biology');


	--	Query: “Find the departments that have the highest average salary.”

SELECT dept_name
FROM instructor
GROUP BY dept_name
HAVING avg(salary) >= ALL (SELECT avg(salary)
						    FROM instructor 
						    GROUP BY dept_name);
						
	
	
----or-----
	
	SELECT dept_name, avg(salary)
	FROM instructor 
	GROUP BY dept_name
	ORDER BY avg(salary) desc;



--	Testing for Empty Relations

	--	Query: “Find all courses taught in both the Fall 2009 semester and in the Spring 2010 semester.”

 SELECT course_id
 FROM section as s
 WHERE semester = 'Fall' AND year = 2009
 AND EXISTS (SELECT *
			 FROM section as t
			WHERE semester = 'Spring' AND year = 2010
			AND s.course_id = t.course_id);
 


	/* 	Query: “Find the total number of (distinct) students who have taken course sections
		taught by the instructor with the ID 34175.”	*/

		--	Previously, we wrote:
 SELECT COUNT(DISTINCT id)
 FROM takes
 WHERE (course_id, sec_id, semester, year) IN (SELECT course_id, sec_id, semester, year
			  FROM teaches as t
			  WHERE t.id = '34175')
			  

			 


		-- Now, we can write:
SELECT COUNT(DISTINCT id)
FROM takes 
WHERE EXISTS (SELECT course_id, sec_id, semester, year
               FROM teaches 
			   WHERE teaches.id = '34175'
			   AND takes.course_id = teaches.course_id
			   AND takes.sec_id = teaches.sec_id
			   AND takes.semester = teaches.semester
			   AND takes.year = teaches.year);


--	Testing for the Absence of Duplicate Tuples

	--	Query: “Find all courses that were offered at most once in 2013.”
	
	SELECT t.course_id
	FROM course as t
	WHERE 1 >=(SELECT COUNT(r.course_id)
			   FROM section as r
			   WHERE t.course_id = r.course_id
			  AND r.year = 2013);



--	Subqueries in the FROM Clause

	/*	Query: “Find the average instructors’ salaries of those departments where the
		average salary is greater than $42,000.”	*/

		--	Previously, we wrote this query as:
						
SELECT avg(salary), dept_name
FROM instructor 
GROUP BY dept_name
HAVING avg(salary) > 42000;


		--	Now, we can write this query as:

SELECT dept_name, avg_salary
FROM	(select dept_name, avg(salary) as avg_salary
		 FROM instructor
		 GROUP BY dept_name) AS dept_avg
WHERE avg_salary > 42000;		 

		--	Note that we must alias subqueries in the FROM clause (i.e. error w/o "foobar"):



		/*	Query: “Find the maximum across all departments of the total of all
			instructors’ salaries in each department.”		*/
			
			SELECT MAX(tot_salary)
			FROM (SELECT SUM(salary) as tot_salary, dept_name
				  FROM instructor
				  GROUP BY dept_name) as dept_total;



--	The WITH Clause

	/*	Query: “Find the names and budgets of departments with the maximum budget
		(there could be more than one department with the maximum budget).”		*/

WITH max_budget(value) AS
    (SELECT MAX(budget)
	 FROM department)
SELECt dept_name, budget
FROM department, max_budget
WHERE department.budget = max_budget.value;

----or----

SELECT dept_name, max(budget)
FROM department
GROUP BY dept_name
ORDER BY max(budget) desc;


	/*	Query: “Find all departments where the total salary is greater than the
		average of the total salary at all departments.”		*/

WITH dept_total (dept_name, value) AS
                 (SELECT dept_name, SUM(salary)
				  FROM instructor
				  GROUP BY dept_name),
				  dept_total_avg (value) AS
				  (SELECT avg(value)
				  FROM dept_total)
			SELECT dept_name	
			FROM dept_total, dept_total_avg
			WHERE dept_total.value = dept_total_avg.value;
				  
				 


--	Scalar Subqueries

	/*	Query: “Find the names of all departments along with the number of
		instructors in each department.”	*/
		
		SELECT dept_name, (SELECT COUNT(*)
						   FROM instructor
						  WHERE department.dept_name = instructor.dept_name)
						  AS num_instructors;
						  
       FROM department;
	   
	   ----or----
	   SELECT d.dept_name, COUNT(DISTINCT id)
	   FROM instructor as i
	   JOIN department as d
	   ON d.dept_name = i.dept_name
	   GROUP BY d.dept_name;


--	Scalar Subqueries Without a From Clause

	/*	Query: “Find the average number of sections taught per instructor
		(regardless of year or semester); sections taught by multiple instructors
		count once per instructor.”		*/
		
		
		SELECT 1.0*(SELECT COUNT(sec_id) FROM teaches)/ (SELECT COUNT(id) FROM instructor);
		
		SELECT 1.0*(SELECT COUNT(*) FROM teaches)/ (SELECT COUNT(*) FROM instructor);
		
		---other scalar subqueries--
		
		SELECT 'Dr. Morabito''s Data Science Course!';
		--above is just a scalar string 
		
		SELECT 4*5^2;
		
		SELECT 1.0/3.0;
		
		SELECT (1/3)
		