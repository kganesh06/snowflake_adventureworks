CREATE OR REPLACE PROCEDURE AddAgeAndAgeGroupColumns()
RETURNS STRING
LANGUAGE JAVASCRIPT
AS
$$
    var sql_command =`
    select *, DATEDIFF('Year',BIRTHDATE, current_date) AS Age, 
case when age >= 20 and age<=30 then '20-30'
 when age >= 31 and age<=40 then '31-40'
 when age >= 41 and age<=50 then '41-50'
 when age >= 51 and age<=60 then '51-60'
 when age >= 61 and age<=70 then '61-70'
 when age >= 61 and age<=70 then '71-80'
end as "AGE GROUP"
from ADVENTUREWORKS.RAW_DATA.Customers`;
    snowflake.execute({ sqlText: sql_command });
    
      // Step 2: Load data from staging table to target table
  sql = 'INSERT INTO adventureworks.adventure.Customers SELECT * FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));';
  stmt = snowflake.createStatement({sqlText: sql});
  stmt.execute();
  
    return 'Customers Data moved to final table';
$$;