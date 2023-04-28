# import pyodbc
#
# server = 'EPUAKYIW1839\SQLEXPRESS' # to specify an alternate port
# database = 'AdventureWorks2012'
# username = 'NewLogin'
# password = '1234567890'
# port = '1433'
# cnxn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER='+server+';DATABASE='+database+';UID='+username+';PWD='+ password)
# cursor = cnxn.cursor()
#
# cursor = cnxn.cursor()
# cursor.execute("SELECT * FROM Production.Product")
# row = cursor.fetchone()
# while row:
#     print (row)
#     row = cursor.fetchone()
#
# cnxn.close()


import urllib
from sqlalchemy import create_engine
import sqlalchemy as db

server = 'EPUAKYIW1839\SQLEXPRESS' # to specify an alternate port
database = 'AdventureWorks2012'
username = 'NewLogin'
password = '1234567890'

# params = urllib.parse.quote_plus("'DRIVER={ODBC Driver 17 for SQL Server};SERVER='+server+';DATABASE='+database+';UID='+username+';PWD='+ password")
# "DRIVER={ODBC Driver 17 for SQL Server};SERVER=EPUAKYIW1839\SQLEXPRESS;DATABASE=AdventureWorks2012;UID=NewLogin;PWD=1234567890"
#engine = create_engine("mssql+pyodbc:///?odbc_connect=%s" % params)
engine = \
    create_engine\
        ("mssql+pyodbc:///?odbc_connect=DRIVER={ODBC Driver 17 for SQL Server};SERVER=EPUAKYIW1839\SQLEXPRESS;DATABASE=AdventureWorks2012;UID=NewLogin;PWD=1234567890")
#engine = create_engine('mssql+pyodbc://NewLogin:1234567890@EPUAKYIW1839\SQLEXPRESS/AdventureWorks2012')
connection = engine.connect()


