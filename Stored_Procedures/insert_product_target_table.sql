CREATE OR REPLACE PROCEDURE ProductTableLoad()
RETURNS STRING
LANGUAGE JAVASCRIPT
AS
$$
    var sql_command = `
    SELECT 
      p.ProductKey,
      p.ProductSubcategoryKey,
      p.ProductName,
      p.StandardCost,
      p.Color,
      p.SafetyStockLevel,
      p.ListPrice,
      p.Size,
      p.SizeRange,
      p.Weight,
      p.DaysToManufacture,
      p.ProductLine,
      p.DealerPrice,
      p.Class,
      p.ModelName,
      p.Description,
      p.Status,
      p.SubCategory,
      p.Category,
      p.StartDate,
      p.EndDate,
      psc.ProductSubcategoryAlternateKey,
      psc.EnglishProductSubcategoryName,
      psc.SpanishProductSubcategoryName,
      psc.FrenchProductSubcategoryName,
      pc.ProductCategoryKey,
      pc.ProductCategoryAlternateKey,
      pc.EnglishProductCategoryName,
      pc.SpanishProductCategoryName,
      pc.FrenchProductCategoryName
    FROM ADVENTUREWORKS.RAW_DATA.Products AS p
    LEFT JOIN ADVENTUREWORKS.RAW_DATA.dimProductSubCategory AS psc ON psc.ProductSubcategoryKey = p.ProductSubcategoryKey
    LEFT JOIN ADVENTUREWORKS.RAW_DATA.dimProductCategory AS pc ON psc.ProductCategoryKey = pc.ProductCategoryKey`;
    
    snowflake.execute({ sqlText: sql_command });
    
    // Step 2: Load data from staging table to target table
    var sql = 'INSERT INTO adventureworks.adventure.Products SELECT * FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()))';
    var stmt = snowflake.createStatement({sqlText: sql});
    stmt.execute();
  
    return 'Product Data moved to final table';
$$;
