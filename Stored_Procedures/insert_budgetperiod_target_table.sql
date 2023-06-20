CREATE OR REPLACE PROCEDURE BudgetPeriodTableLoad()
RETURNS Varchar
LANGUAGE JAVASCRIPT
AS
$$
    var sql_command = `
    SELECT *
    FROM ADVENTUREWORKS.RAW_DATA.BudgetPeriod`;
 
    snowflake.execute({ sqlText: sql_command });
    
    // Step 2: Load data from staging table to target table
    var sql = 'INSERT INTO adventureworks.adventure.BudgetPeriod SELECT * FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()))';
    var stmt = snowflake.createStatement({sqlText: sql});
    stmt.execute();
  
    return 'BudgetPeriod Data moved to final table';
$$;