/* 
This worksheet will be used for various tasks during the Snowflake tutorial: Developing an Application with the Native Apps Framework 
Not all required lines are here as some are used in another files. However, this worksheet follows the tutorial steps and may be used
to accompany it. 
*/

/* Run this to set application context  */ 
USE APPLICATION PACKAGE hello_snowflake_package;
/* --- 1. Create application package */
/* Run this line to grant CREATE APPLICATION to the desired role */
GRANT CREATE APPLICATION PACKAGE ON ACCOUNT TO ROLE accountadmin;

/* Create APPLICATION PACKAGE named hello_snowflake_package */
CREATE APPLICATION PACKAGE hello_snowflake_package;

/* Verify its existence by running this: */
SHOW APPLICATION PACKAGES;


/* --- 2. Upload files into stage */
/* Create a schema and a stage */
CREATE SCHEMA stage_content;
CREATE OR REPLACE STAGE hello_snowflake_package.stage_content.hello_snowflake_stage
  FILE_FORMAT = (TYPE = 'csv' FIELD_DELIMITER = '|' SKIP_HEADER = 1);

/* Upload using PUT command. Change lines to include your path */
PUT file:///<path_to_your_root_folder>/tutorial/manifest.yml @hello_snowflake_package.stage_content.hello_snowflake_stage overwrite=true auto_compress=false;
PUT file:///<path_to_your_root_folder>/scripts/setup.sql @hello_snowflake_package.stage_content.hello_snowflake_stage/scripts overwrite=true auto_compress=false;
PUT file:///<path_to_your_root_folder>/tutorial/readme.md @hello_snowflake_package.stage_content.hello_snowflake_stage overwrite=true auto_compress=false;

/* Verify these were staged */
LIST @hello_snowflake_package.stage_content.hello_snowflake_stage;


/* --- 3. Create the app using the staged files */
CREATE APPLICATION HELLO_SNOWFLAKE_APP
  FROM APPLICATION PACKAGE HELLO_SNOWFLAKE_PACKAGE
  USING '@hello_snowflake_package.stage_content.hello_snowflake_stage';

/* Confirm that the app exists */
  SHOW APPLICATIONS;

/* Run Stored Procedure created previously */
  CALL core.hello();


/* --- 4. Create and add data to the app */
/* Create schema and table, then insert data into it */
CREATE SCHEMA IF NOT EXISTS shared_data;
CREATE TABLE IF NOT EXISTS accounts (ID INT, NAME VARCHAR, VALUE VARCHAR);
INSERT INTO accounts VALUES
  (1, 'Nihar', 'Snowflake'),
  (2, 'Frank', 'Snowflake'),
  (3, 'Benoit', 'Snowflake'),
  (4, 'Steven', 'Acme');

/* Verify successfull insertion with a SELECT * statement */
SELECT * FROM accounts;

/* Grant USAGE for this table */
GRANT USAGE ON SCHEMA shared_data TO SHARE IN APPLICATION PACKAGE hello_snowflake_package;
GRANT SELECT ON TABLE accounts TO SHARE IN APPLICATION PACKAGE hello_snowflake_package;


/* --- 5. Test updated application */
/* Drop the app */
DROP APPLICATION hello_snowflake_app;

/* Run this line again to create a new version of the app */
CREATE APPLICATION hello_snowflake_app
  FROM APPLICATION PACKAGE hello_snowflake_package
  USING '@hello_snowflake_package.stage_content.hello_snowflake_stage';

/* Test it */
SELECT * FROM code_schema.accounts_view;


/* 6. Upload python external module and update setup.sql */
PUT file:///<path_to_your_root_folder>/tutorial/scripts/setup.sql @hello_snowflake_package.stage_content.hello_snowflake_stage/scripts overwrite=true auto_compress=false;
PUT file:///<path_to_your_root_folder>/tutorial/python/hello_python.py @hello_snowflake_package.stage_content.hello_snowflake_stage/python overwrite=true auto_compress=false;

/* Verify these were staged */
LIST @hello_snowflake_package.stage_content.hello_snowflake_stage;

/* 7. Test module */
DROP APPLICATION hello_snowflake_app;

/* Run this line again to create a new version of the app */
CREATE APPLICATION hello_snowflake_app
  FROM APPLICATION PACKAGE hello_snowflake_package
  USING '@hello_snowflake_package.stage_content.hello_snowflake_stage';

/* Test python UDF */
SELECT code_schema.addone(1);

/* Test python external module */
SELECT code_schema.multiply(1,2);