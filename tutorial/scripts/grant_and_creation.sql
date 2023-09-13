/* This worksheet will be used for creating objects and granting access during the tutorial */

/* Run this to set context if you logged out */ 
USE APPLICATION PACKAGE hello_snowflake_package;



/* Run this line to grant CREATE APPLICATION to the desired role */
GRANT CREATE APPLICATION PACKAGE ON ACCOUNT TO ROLE accountadmin;
/* Create APPLICATION PACKAGE named hello_snowflake_package */
CREATE APPLICATION PACKAGE hello_snowflake_package;
/* Verify its existence by running this: */
SHOW APPLICATION PACKAGES;


CREATE SCHEMA stage_content;
CREATE OR REPLACE STAGE hello_snowflake_package.stage_content.hello_snowflake_stage
  FILE_FORMAT = (TYPE = 'csv' FIELD_DELIMITER = '|' SKIP_HEADER = 1);
