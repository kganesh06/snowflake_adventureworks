CREATE OR REPLACE PROCEDURE master_sp()
RETURNS STRING
LANGUAGE JAVASCRIPT
AS
$$
    // Call remove_duplicates_and_load
    snowflake.execute({sqlText: 'CALL remove_duplicates_and_load();'});
    
    // Call AddAgeAndAgeGroupColumns
    snowflake.execute({sqlText: 'CALL AddAgeAndAgeGroupColumns();'});
    
    // Call ProductTableLoad
    snowflake.execute({sqlText: 'CALL ProductTableLoad();'});

    // Call BudgetTableLoad
    snowflake.execute({sqlText: 'CALL BudgetTableLoad();'});

    // Call BudgetPeriodTableLoad
    snowflake.execute({sqlText: 'CALL BudgetPeriodTableLoad();'});

    // Call TerritoryTableLoad
    snowflake.execute({sqlText: 'CALL TerritoryTableLoad();'});

    // Call SalesTableLoad
    snowflake.execute({sqlText: 'CALL SalesTableLoad();'});
    
    return 'Sequence of SPs executed successfully.';
$$;