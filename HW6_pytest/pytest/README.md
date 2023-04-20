This code is a test suite for a database with three tables, namely, Production.Document, Person.Address, and Production.UnitMeasure.
The tests verify whether the database tables follow specific requirements.

Setup
To run this code, you must have pytest and pymssql installed in your environment.

Use the following command to install the required libraries:
pip install pytest pymssql pytest-html


Before running the tests, you need to provide the necessary connection 
details to the database in the db_connection function in test_sql_server_db.py
Update the values to match the database connection details.

To run the tests, navigate to the root directory 
of the project and execute the following command:

 pytest test_sql_server_db.py --html=report.html --self-contained-html 

This test suite contains nine test cases.
The output of the tests will be displayed on the console. 
