/* This worksheet contains various commands to load previously created data into the Snowflake account. These tables were created using the script create_tables.py */

/* Create database and schema for tables  */
CREATE OR REPLACE DATABASE financial_records;
CREATE OR REPLACE SCHEMA financial_records.objects;

/* Create the empty tables */
CREATE OR REPLACE TABLE financial_records.objects.company(
    id int
    ,industry varchar
    ,sector varchar
    ,active boolean    
    ,price float
    ,comment varchar 
);

CREATE OR REPLACE TABLE financial_records.objects.stocks (
        id int
        ,currency varchar
        ,date datetime
        ,open int
        ,high int
        ,low int
        ,close int
        ,active boolean
);

/* Create a stage with a file format to load data */
CREATE OR REPLACE STAGE financial_records.objects.load_csv 
  FILE_FORMAT = (TYPE = 'csv' FIELD_DELIMITER = ',' SKIP_HEADER = 1);
/* Load files into stage. LIST and REMOVE are added here if case they're needed */
PUT file:///<your>/<path>/finance_app/data/company.csv @financial_records.objects.load_csv overwrite=true auto_compress=false;
PUT file:///<your>/<path>/finance_app/data/company.csv/finance_app/data/stocks.csv @financial_records.objects.load_csv overwrite=true auto_compress=false;
LIST @financial_records.objects.load_csv; 
REMOVE @financial_records.objects.load_csv;

/* Copy your data into the Snowflake tables */
COPY INTO financial_records.objects.company from @load_csv PURGE = TRUE;
COPY INTO financial_records.objects.stocks from @load_csv PURGE = TRUE;