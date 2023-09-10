--------------------------------------------------------------
/*			 More Advanced Database Modifications		  	*/
--------------------------------------------------------------

--	Deletion

    /*  Query: “Delete all tuples in the instructor relation for those instructors
        associated with a department located in the Watson building.”       */
		
		DELETE FROM instructor 
		WHERE dept_name IN (SELECT dept_name
						   FROM department
						   WHERE building = 'Watson');
---check						   
 
 SELECT * 
 FROM instructor
 WHERE dept_name IN (SELECT dept_name
                      FROM department 
                      WHERE building = 'Watson');
			

	/*	Query: “Delete the records of all instructors with a salary below the average
		at the university.”		*/

			DELETE FROM instructor
			WHERE salary < (select avg(salary)
						   FROM instructor);


--	Insertion

	/*	Query: “Make each student in the Music department who has earned more than 144
		credit hours an instructor in the Music department with a salary of $18,000.”	*/
		
		
		INSERT INTO instructor 
	     (SELECT id, name,dept_name, 18000
		  FROM student
		  WHERE dept_name = 'Music' AND tot_cred > 144);



--	Updation

	--	Query: “Give a 5 percent salary raise to instructors whose salary is less than average.”
	
	UPDATE instructor 
	SET salary = salary * 1.05
	WHERE salary < (select avg(salary)
				     from instructor);



	/*	Query: “Give all instructors whose salary is over $100,000 a 3 percent salary raise,
		and give all other instructors a 5 percent raise.	*/
		
		
		UPDATE instructor 
		SET salary = salary * 1.03
		WHERE salary > 100000;
		
		UPDATE instructor 
		SET salary = salary * 1.05
		WHERE salary <= 100000;
		
		----or------
		
		UPDATE instructor 
		SET salary = case
		               WHEN salary <= 100000 THEN salary * 1.05
					   ELSE salary * 1.03
					    END



	/*	
		DUE TO ALL OF THE ABOVE DATABASE MODIFICATIONS WE JUST EMPLOYED, IT IS A GOOD IDEA TO
		DELETE ALL THE TUPLES IN THE UNIVERSITY_SMALL DATABASE AND RE-INSERT THE DATA TO MAINTAIN
		THE INTEGRITY OF THE DATA FOR FUTURE QUERIES
	*/
	     
			








		/* General Form of CASE construct:

			CASE
				WHEN pred1 THEN result1
				WHEN pred2 THEN result2
				…
				WHEN predN THEN resultN
				ELSE result0
			END								*/