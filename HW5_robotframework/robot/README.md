
#### This is a sample Robot Framework project to test SQL queries against a Microsoft SQL Server database using the pymssql library.

## Create a virtual environment for test execution

The following are the pre-requisites for running the tests in this project:

* Python 3.x
* Robot Framework
* Robot Framework DatabaseLibrary
* pymssql library

1. Use the following command to install the required libraries:
*pip install robotframework pymssql robotframework-databaselibrary*
2. Open folder where project will be and use the following command in CLI to clone project to your local machine (**git should be installed**)
 *gh repo clone MrCmert/Course_Intermediate_DQE*

## Database Connection Setup

Before running the tests, you need to provide the necessary connection details to the database in the Variables section of the
[Resources\Variables.robot](https://github.com/MrCmert/Course_Intermediate_DQE/blob/main/HW5_robotframework/robot/Resources/Variables.robot "Named link title") file.
Update the values to match your database connection details.

## Run robot tests

To run the tests, navigate to the root directory of the project and execute the following command:
*robot Tests\TestCasesMSSQL.robot*

## Test Cases Run Result

The output of the tests will be displayed on the console. 
If a test fails, the reason for failure will be displayed in the console output. Additionally, Robot Framework will generate an HTML report and a log file in the output directory. Path to your report: *{path to the project}/HW5_robotframework/robot/report.html*
The HTML report can be opened in a web browser to view the results of the tests. 
[Example of report](https://github.com/MrCmert/Course_Intermediate_DQE/blob/main/HW5_robotframework/robot/report.html "Named link title")
