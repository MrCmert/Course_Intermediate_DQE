*** Settings ***
Library           DatabaseLibrary
Library           pymssql

*** Variables ***
${DB_HOST}        EPUAKYIW1839
${DB_NAME}        AdventureWorks2012
${DB_USER}        NewLogin
${DB_PASSWORD}    1234567890
${DB_PORT}        50768

*** Test Cases ***
Check rowguid column in Person.Address table for correct length
    ${conn}=    pymssql.Connect    server=${DB_HOST}:${DB_PORT}    user=${DB_USER}    password=${DB_PASSWORD}    database=${DB_NAME}
    ${query}=    Set Variable    SELECT [rowguid] FROM [Person].[Address]
    ${results}=    Query    ${conn}    ${query}
    FOR    ${row}    IN    @{results}
        ${rowguid}=    Set Variable    ${row}[rowguid]
        ${length}=    Get Length    ${rowguid}
        Should Be Equal As Integers    ${length}    36    msg=Rowguid ${rowguid} has length ${length}, which is not 36.
    END
    ${conn}.close()


Verify empty result set
    ${conn}=    pymssql.Connect    server=${DB_HOST}    user=${DB_USER}    password=${DB_PASSWORD}    database=${DB_NAME}
    ${query}=    Set Variable    SELECT * FROM [Person].[Address] WHERE ModifiedDate > CURRENT_TIMESTAMP
    ${results}=    Query    ${conn}    ${query}
    Should Be Empty    ${results}    msg=Query returned ${len(results)} record(s), but should have returned 0.
    ${conn}.close()