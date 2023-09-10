--------------------------------------------------------------
/*		                Functions in SQL                    */
--------------------------------------------------------------

--  Functions and Procedures

    /*
        A Word of Caution:

            Most DBMSs implement nonstandard versions of the syntax specified in the SQL
            standard for functions and procedures.  Functions and procedures can be
            created in a procedural language of your choice - we will be using PL/pgSQL
            of PostgreSQL.  Since there are numerous procedural langauges that can be
            used to express functions and procedures, you should be very careful when
            searching Google for help writing functions and procedures - be sure that
            your references refer to the same procedural language esension you are using!

        Important Points for Functions/Procedures in PostgreSQL:

            Functions  -> Invoked from SELECT statement
            Procedures -> Invoked using the CALL keyword

            Functions  -> Cannot perform database modifications
            Procedures -> Can perform database modifications
    */

--  Declaring and Invoking SQL Functions

    /*
        Now, we will consider how to write our own functions and procedures,
        store them in the database, and then invoke them as SQL statements.
    */

    /*
        General Usage of the CREATE FUNCTION statement:

    CREATE [ OR REPLACE ] FUNCTION name
        ( [ [ argmode ] [ argname ] argtype [ { DEFAULT | = } default_expr ] [, ...] ] )
        [ RETURNS rettype
            | RETURNS TABLE ( column_name column_type [, ...] ) ]
        { LANGUAGE lang_name
            | WINDOW
            | IMMUTABLE | STABLE | VOLATILE
            | CALLED ON NULL INPUT | RETURNS NULL ON NULL INPUT | STRICT
            | [ EXTERNAL ] SECURITY INVOKER | [ EXTERNAL ] SECURITY DEFINER
            | COST execution_cost
            | ROWS result_rows
            | SET configuration_parameter { TO value | = value | FROM CURRENT }
            | AS 'definition'
            | AS 'obj_file', 'link_symbol'
        } ...
        [ WITH ( attribute [, ...] ) ]

    -- Below is a more useful version of the complete usage syntax:

        CREATE OR REPLACE <function_name>(<param_1> <paramType_1>, ...)
        RETURNS <return_type>
        LANGUAGE plpgsql
        AS
        $$
            -- Variable Declarations
            DECLARE
            	<...>
            -- SQL Statements
            BEGIN
            	<...>
            END;
        $$;

    */

--  Dollar-Quoted String Constants

SELECT $foobar$ my string here $foobar$;

SELECT $$this is my string literal$$;

        

--  The BEGIN...END Construct

        -- This BEGIN … END construct indicates a compound statement

--  The DECLARE Statement

        /*  Variables are declared using the DECLARE statement and have any valid
            SQL data type.  Assignments, in PostgreSQL, are performed using a
            colon-equals notation. For example,

				my_int := 3;        */

-- More information about the CREATE FUNCTION statement can be found at:
-- https://www.postgresql.org/docs/9.1/sql-createfunction.html