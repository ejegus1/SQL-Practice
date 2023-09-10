-------------------------------------------------------------------
/* -------------------- Introduction to SQL -------------------- */
-------------------------------------------------------------------

------------------------- Create Database -------------------------
-- CREATE DATABASE database_name;

CREATE DATABASE testing_DB;



-------------------------- Drop Database --------------------------
-- DROP DATABASE database_name;

DROP DATABASE testing_DB;


--------------------------- Create Table --------------------------
/* CREATE TABLE table_name	(attribute_1 data_type_1,
							attribute_2 data_type_2,
							...
							attribute_n data_type_n,
							<integrity_constraint_1>,
							<...>,
							<integrity_constraint_m>); */
							
  /* This is a 
   multiline comment.*/
   
   -- This is an inline comment.
   
   Create TABLE instructor(
   	 ID        varchar(5),
	 name      varchar(20),
	 dept_name  varchar(20),
	 salary     numeric(8,2)
   );


--------------------------- Drop Table ----------------------------
-- DROP TABLE table_name;

DROP TABLE instructor;





------------------- Inserting Tuples into Tables ------------------
/* INSERT INTO table_name (att_1, ..., att_n)
   VALUES 	(value_1, ..., value_n);	*/
   
   INSERT INTO instructor(ID, name, dept_name, salary)
   VALUES('99999', 'Ej Smith', 'Data. Sci.', 100000.00)
   
   INSERT INTO instructor
   VALUES('88888', 'Fana Gidey', 'Comp. Sci.', 100000.00)
   
   INSERT INTO instructor(name, ID, salary, dept_name)
   VALUES('Rebel', '77777', 100000.00, 'Comp. Sci.')



------------------- Deleting Tuples from Tables -------------------
-- DELETE FROM table_name;

DELETE FROM instructor; -- Delete everything from the instructor table

DELETE
FROM instructor
WHERE name = 'Fana Gidey' --deleting a tuple from a table




------------- Create Table with Primary Key Constraint ------------
-- CONSTRAINT consName PRIMARY KEY ( attName_1, …, attName_n )

-- Primary key attributes are required to be non-null and unique
-- Give a name to constraint as it is easier to know what error has been violated when coding

  Create TABLE instructor(
   	 ID        varchar(5),
	 name      varchar(20),
	 dept_name  varchar(20),
	 salary     numeric(8,2),
	  CONSTRAINT instructor_pkey PRIMARY KEY(ID)
   );





------------- Create Table with Foreign Key Constraint ------------
/* CONSTRAINT consName FOREIGN KEY (local_att(s))
   REFERENCES foreign_table (foreign_att(s))	*/
   
   DROP TABLE classroom;
   
   CREATE TABLE course(
	   course_id varchar(8),
	   title     varchar(50),
	   dept_name varchar(20),
	   credits   numeric(2,0),
	   CONSTRAINT course_pkey PRIMARY KEY(course_id)
   
   );
   
   CREATE TABLE classroom (
	   building     varchar(15),
	   room_number  varchar(7),
	   capacity     numeric(4,0),
	   CONSTRAINT classroom_pkey PRIMARY KEY(building, room_number)
   
   );
   
   
CREATE TABLE section (
	course_id   varchar(8),
	sec_id      varchar(8),
	semester    varchar(6),
	year        numeric(4,0),
	building    varchar(15),
	room_number varchar (7),
	time_slot_id varchar(4),
		CONSTRAINT section_pkey PRIMARY KEY (course_id, sec_id,semester, year),
		CONSTRAINT section_fkey_1 FOREIGN KEY (course_id) REFERENCES course (course_id)
	    ON DELETE CASCADE,
		CONSTRAINT section_fkey_2 FOREIGN KEY (building, room_number) REFERENCES classroom(building, room_number)
	    ON DELETE SET NULL
	

);

/* ON DELETE CASCADE
   ON DELETE SET NULL
   ON DELETE SET DEFAULT
   
   ON UPDATE CASCADE
   ON UPDATE SET NULL
   ON UPDATE SET DEFAULT
 */

----------------------- Not Null Constraint -----------------------
-- attributeName dataType NOT NULL

  Create TABLE instructor(
   	 ID        varchar(5),
	 name      varchar(20) NOT NULL,
	 dept_name  varchar(20),
	 salary     numeric(8,2),
	  CONSTRAINT instructor_pkey PRIMARY KEY(ID)
   );



----------------------- Check Constraints -------------------------

CREATE TABLE department (
	department_name  varchar(20),
	building         varchar(15),
	budget           numeric(12,2) Constraint positive_budget check(budget > 0.00)


);


------------------- Default Attribute Values ----------------------

CREATE TABLE student (
	ID        varchar(5),
	name      varchar(20)   NOT NULL,
	dept_name  varchar(20)   DEFAULT 'Exploratory Studies',
	total_cred numeric(3,0)  DEFAULT 0

);


----------------------- Updating Relations ------------------------
/* UPDATE 	table_name
   SET		condition/action
   WHERE 	predicate;	*/

INSERT INTO student (ID, name)
VALUES('97854', 'Larry David');

UPDATE student
SET dept_name = 'Physics'
WHERE name = 'Larry David';

SELECT * 
FROM student;




----------------------- Altering Relations ------------------------
/* ALTER TABLE table_name ADD att_name data_type;
   ALTER TABLE table_name DROP attribute_name;

   ALTER TABLE table_name ADD constraintName
   ALTER TABLE table_name DROP constraintName	*/

ALTER TABLE student ADD age numeric(2,0);
ALTER TABLE student DROP age;

ALTER TABLE student ADD CONSTRAINT agecheck CHECK(age > 17);

SELECT * 
FROM student;



