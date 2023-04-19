*** Settings ***
Documentation     Robot resources and variables for all tests

Library           DatabaseLibrary
Library           OperatingSystem
Library           pymssql

*** Variables ***
${DB_HOST}        172.19.32.1
${DB_NAME}        AdventureWorks2012
${DB_USER}        NewLogin
${DB_PASSWORD}    1234567890
${DB_PORT}        1433