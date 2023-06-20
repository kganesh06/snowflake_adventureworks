CREATE OR REPLACE PROCEDURE remove_duplicates_and_load()
RETURNS VARCHAR
LANGUAGE JAVASCRIPT
AS
$$
  var stmt;
  var sql;
  
  // Step 1: Delete duplicate records from staging table
  sql = `SELECT 
              ID,
              Date,
              DayNumberOfWeek,
              DayName,
              MonthName,
              MonthNumberOfYear,
              DayNumberOfYear,
              WeekNumberOfYear, 
              CalendarQuarter,
              CalendarYear,
              FiscalYear,
              FiscalSemester,
              FiscalQuarter,
              FinMonthNumberOfYear, 
              DayNumberOfMonth, 
              Period, 
              MonthID
         FROM (
              SELECT *,
                     ROW_NUMBER() OVER (PARTITION BY id ORDER BY id ASC NULLS LAST) AS rn
              FROM adventureworks.raw_data.Calendar
              ) AS rownum
         WHERE rn = 1`;
  
  stmt = snowflake.createStatement({sqlText: sql});
  stmt.execute();

  // Step 2: Load data from staging table to target table
  sql = 'INSERT INTO adventureworks.adventure.Calendar SELECT * FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));';
  stmt = snowflake.createStatement({sqlText: sql});
  stmt.execute();
  
  return "Data loaded successfully.";
$$;
