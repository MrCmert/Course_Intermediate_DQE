import pytest
import pymssql


@pytest.fixture(scope="module")
def db_connection():
    conn = pymssql.connect(server=r'EPUAKYIW1839',
                           port='1433',
                           user=r'NewLogin',
                           password=r'1234567890',
                           database=r'AdventureWorks2012')
    yield conn
    conn.close()
