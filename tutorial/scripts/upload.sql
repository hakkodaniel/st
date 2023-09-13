/* This worksheet will be used for uploading-related tasks during the tutorial */

PUT file:///Users/danielgonzalez/Documents/dev/st/tutorial/manifest.yml @hello_snowflake_package.stage_content.hello_snowflake_stage overwrite=true auto_compress=false;
PUT file:///Users/danielgonzalez/Documents/dev/st/tutorial/scripts/setup.sql @hello_snowflake_package.stage_content.hello_snowflake_stage/scripts overwrite=true auto_compress=false;
PUT file:///Users/danielgonzalez/Documents/dev/st/tutorial/readme.md @hello_snowflake_package.stage_content.hello_snowflake_stage overwrite=true auto_compress=false;