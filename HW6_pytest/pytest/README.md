This code is a test suite for a database with three tables, namely, Production.Document, Person.Address, and Production.UnitMeasure.
The tests verify whether the database tables follow specific requirements.

## Create a virtual environment for test execution

The following are the pre-requisites for running the tests in this project:

* Python 3.x
* pytest library
* pytest-html library
* pymssql library

To run this code, you must have pytest and pymssql installed in your environment.

1. Use the following command to install the required libraries:
***pip install pytest pymssql pytest-html***
2. Open folder where project will be and use the following command in CLI to clone project to your local machine (**git should be installed**):
 ***gh repo clone MrCmert/Course_Intermediate_DQE***

## Database Connection Setup

Before running the tests, you need to provide the necessary connection details to the database in the Variables section of the
[Resources\Variables.robot](https://github.com/MrCmert/Course_Intermediate_DQE/blob/main/HW6_pytest/pytest/connection.py "Named link title") file.
Update the values to match your database connection details.

## Run pytest tests
To run the tests, navigate to the root directory of the project and execute the following command:
***pytest test_sql_server_db.py***

This test suite contains nine test cases.
The output of the tests will be displayed on the console. 

## Test Cases Run Result

To generate the report execute the following command:
***pytest --html=report.html --self-contained-html***

To find your report follow to: *{path to the project}/HW6_pytest/pytest/report.html*
The HTML report can be opened in a web browser to view the results of the tests. 
[Example of report](https://github.com/MrCmert/Course_Intermediate_DQE/blob/main/HW6_pytest/pytest/report.html "Named link title")
