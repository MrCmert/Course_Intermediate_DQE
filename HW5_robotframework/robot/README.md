This is a sample Robot Framework project to test SQL queries 
against a Microsoft SQL Server database using the pymssql library.

Setup
The following are the pre-requisites for running the tests in this project:

Python 3.x
Robot Framework
Robot Framework DatabaseLibrary
pymssql library

Use the following command to install the required libraries:
pip install robotframework pymssql robotframework-databaselibrary


Before running the tests, you need to provide the necessary connection 
details to the database in the Variables section of the 
Resources\Variables.robot file.
Update the values to match the database connection details.

To run the tests, navigate to the root directory 
of the project and execute the following command:

robot Tests\TestCasesMSSQL.robot



The output of the tests will be displayed on the console. 
If a test fails, the reason for failure will be displayed in the console output. Additionally, Robot Framework will generate an HTML report and a log file in the output directory.
The HTML report can be opened in a web browser to view the results of the tests.