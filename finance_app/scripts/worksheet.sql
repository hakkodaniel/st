/* This worksheet will be used for various tasks for the demo project Finance App.  */

/* Grant CREATE APPLICATION to the desired role */
GRANT CREATE APPLICATION PACKAGE ON ACCOUNT TO ROLE accountadmin;

/* Create APPLICATION PACKAGE named hello_snowflake_package */
CREATE APPLICATION PACKAGE hello_snowflake_package;

/* Verify its existence by running this: */
SHOW APPLICATION PACKAGES;