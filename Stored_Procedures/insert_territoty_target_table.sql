CREATE OR REPLACE PROCEDURE TerritoryTableLoad()
RETURNS Varchar
LANGUAGE JAVASCRIPT
AS
$$
    var sql_command = `
    SELECT *
    FROM ADVENTUREWORKS.RAW_DATA.Territory`;
 
    snowflake.execute({ sqlText: sql_command });
    
    // Step 2: Load data from staging table to target table
    var sql = 'INSERT INTO ADVENTUREWORKS.adventure.Territory SELECT * FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()))';
    var stmt = snowflake.createStatement({sqlText: sql});
    stmt.execute();
  
    return 'Territory Data moved to final table';
$$;