COPY INTO ADVENTUREWORKS.RAW_DATA.Budget (Category, Budget, Period)
FROM @s3_data/Dataset/Budget.csv
FILE_FORMAT = (TYPE = CSV,SKIP_HEADER = 1);


COPY INTO ADVENTUREWORKS.RAW_DATA.BudgetPeriod
FROM @s3_data/Dataset/BudgetPeriod.csv
FILE_FORMAT = file_format;



COPY INTO ADVENTUREWORKS.RAW_DATA.Calendar
FROM @s3_data/Dataset/Calendar.csv
FILE_FORMAT = file_format; 



COPY INTO ADVENTUREWORKS.RAW_DATA.Customers
FROM @s3_data/Dataset/Customers.csv
FILE_FORMAT = file_format; 


COPY INTO ADVENTUREWORKS.RAW_DATA.dimProductCategory
FROM @s3_data/Dataset/dimProductCategory.csv
FILE_FORMAT = file_format;


COPY INTO ADVENTUREWORKS.RAW_DATA.dimProductSubCategory
FROM @s3_data/Dataset/dimProductSubCategory.csv
FILE_FORMAT = file_format;


COPY INTO ADVENTUREWORKS.RAW_DATA.Products
FROM @s3_data/Dataset/Products.csv
FILE_FORMAT = file_format;


COPY INTO ADVENTUREWORKS.RAW_DATA.Sales
FROM @s3_data/Dataset/Sales.csv
FILE_FORMAT = file_format;


COPY INTO ADVENTUREWORKS.raw_data.Territory
FROM @s3_data/Dataset/Territory.csv
FILE_FORMAT = file_format;