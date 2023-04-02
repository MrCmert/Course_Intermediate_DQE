*** Settings ***
Suite Setup       Connect To Database    pymssql     ${DB_NAME}   ${DB_USER}   ${DB_PASSWORD}   ${DB_HOST}   ${DB_PORT}
Suite Teardown    Disconnect From Database
Library           DatabaseLibrary
Library           OperatingSystem
Library           pymssql

*** Variables ***
${DB_HOST}        localhost
${DB_NAME}        AdventureWorks2012
${DB_USER}        NewLogin
${DB_PASSWORD}    1234567890
${DB_PORT}        50768

*** Test Cases ***
Table [Person].[Address]. Lengths of values of column rowguid is equal 36 for all records
    Row Count Is 0	    SELECT * FROM [Person].[Address] WHERE LEN(rowguid) != 36;


Table [Person].[Address]. Column ModifiedDate doesn’t contain future dates
   Row Count Is 0	    SELECT * FROM [Person].[Address] WHERE ModifiedDate > CURRENT_TIMESTAMP;


Table [Production].[Document]. Values of column [DocumentLevel] in range (0, 1, 2)
    Row Count Is 0	    SELECT * FROM [Production].[Document] WHERE [DocumentLevel] not in (0, 1, 2);


Table [Production].[Document]. Values of column [Owner] between 217 and 220
    Row Count Is 0	    SELECT * FROM [Production].[Document] WHERE [Owner] not between 217 and 220;


Table [Production].[UnitMeasure]. Column UnitMeasureCode doesn’t contain null values
    Row Count Is 0	    SELECT * FROM [Production].[UnitMeasure] WHERE UnitMeasureCode is null;


Table [Production].[UnitMeasure]. Verify max\min values of UnitMeasureCode column
    ${queryResults}=  Query   SELECT MAX(UnitMeasureCode) as max_value, MIN(UnitMeasureCode) as min_value FROM [Production].[UnitMeasure];
    Should Be Equal As Strings   '${queryResults[0][0].strip()}'    'PT'
    Should Be Equal As Strings   '${queryResults[0][1].strip()}'    'BOX'