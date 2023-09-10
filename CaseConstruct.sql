--------------------------------------------------------------
/*			 			The CASE Construct		  			*/
--------------------------------------------------------------

--	The CASE Construct

	/*	Query: “Give all instructors whose salary is over $100,000 a 3 percent salary raise,
		and give all other instructors a 5 percent raise.”		*/
			
			-- Previosuly we wrote:
			UPDATE instructor 
			SET salary = salary * 1.03
			WHERE salary > 100000;
			
			UPDATE instructor 
			SET salary = salary * 1.05
			WHERE salary <= 100000;
		

			-- Now we can rewrite using the CASE construct:
			
			UPDATE instructor 
			SET salary = CASE
			                 WHEN salary > 100000
							 THEN salary * 1.03
							 ELSE salary * 1.05
							 END;
			

    /* General Form of CASE construct:

        CASE
            WHEN pred1 THEN result1
            WHEN pred2 THEN result2
            …
            WHEN predN THEN resultN
            ELSE result0
        END

    */

	/*	Query: 	"Find the names and IDs of all instructors at the university.  Additionally, create an attribute
				named "pay_status".  Select the value for this attribute to be "UNDERPAID" if an instructor's salary
				is below $45,000.  Select the value for this attribute to be "PAID" if an instructor's salary is
				equal to or greater than $45,000 and less than or equal to $80,000.  Finally, select the value for
				this attribute to be "OVERPAID" if an instructor's salary is greater than $80,000."	*/

       SELECT name, id, salary,
	CASE 
	    WHEN salary < 45000 THEN 'underpaid'
	    WHEN salary >= 45000 AND salary <=80000 THEN 'paid'
	    ELSE 'overpaid'
	END AS Pay_status
	FROM instructor;
	   

    --	Equivalently, we could have written:
	
	SELECT name, id, salary,
	CASE 
	    WHEN salary < 45000 THEN 'underpaid'
	    WHEN salary >= 45000 AND salary <=80000 THEN 'paid'
	    WHEN salary > 80000 THEN 'overpaid'
	END AS Pay_status
	FROM instructor;