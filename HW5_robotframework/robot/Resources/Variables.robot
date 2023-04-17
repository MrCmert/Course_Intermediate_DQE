*** Settings ***
Documentation     Robot resources and variables for all tests

Library           DatabaseLibrary
Library           OperatingSystem
Library           pymssql

*** Variables ***
${DB_HOST}        EPUAKYIW1839\SQLEXPRESS
${DB_NAME}        AdventureWorks2012
${DB_USER}        NewLogin
${DB_PASSWORD}    1234567890
${DB_PORT}        50768