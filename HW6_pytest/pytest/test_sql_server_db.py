import pytest
import pymssql


@pytest.fixture(scope="module")
def db_connection():
    conn = pymssql.connect(server=r'EPUAKYIW1839',
                           port='50768',
                           user=r'NewLogin', password=r'1234567890', database=r'AdventureWorks2012')
    yield conn
    conn.close()


class TestTableProductionDocument:
    def test_documentlevel_range_in_0_1_2(self, db_connection):
        query = "SELECT [DocumentLevel] FROM [Production].[Document]"
        cursor = db_connection.cursor()
        cursor.execute(query)
        results = cursor.fetchall()
        valid_values = [0, 1, 2]
        for result in results:
            assert result[0] in valid_values, f"DocumentLevel value {result[0]} is not in the expected range"

    def test_owner_between_217_and_220(self, db_connection):
        query = "SELECT * FROM [Production].[Document] WHERE [Owner] not between 217 and 220;"
        cursor = db_connection.cursor()
        cursor.execute(query)
        results = cursor.fetchall()
        assert len(results) == 0, f"Owners out of range for {len(results)} records"


class TestTablePersonAddress:
    def test_rowguid_len_not_equal_36(self, db_connection):
        query = "SELECT * FROM [Person].[Address] WHERE LEN(rowguid) != 36;"
        cursor = db_connection.cursor()
        cursor.execute(query)
        results = cursor.fetchall()
        assert len(results) == 0, f"Len of rowguid is incorrect for {len(results)} records"

    def test_no_modifieddate_in_future(self, db_connection):
        query = "SELECT * FROM [Person].[Address] WHERE ModifiedDate > CURRENT_TIMESTAMP;"
        cursor = db_connection.cursor()
        cursor.execute(query)
        results = cursor.fetchall()
        assert len(results) == 0, f"ModifiedDate column have future date for {len(results)} records"


class TestTableProductionUnitMeasure:
    def test_unitmeasurecode_doesnt_contain_null(self, db_connection):
        query = "SELECT * FROM [Production].[UnitMeasure] WHERE UnitMeasureCode is null;"
        cursor = db_connection.cursor()
        cursor.execute(query)
        results = cursor.fetchall()
        assert len(results) == 0, f"UnitMeasureCode is null for {len(results)} records"

    def test_min_max_value_of_unitmeasurecode(self, db_connection):
        query = "SELECT MAX(UnitMeasureCode) as max_value, MIN(UnitMeasureCode) as min_value " \
                "FROM [Production].[UnitMeasure];"
        cursor = db_connection.cursor()
        cursor.execute(query)
        results = cursor.fetchall()
        assert results[0][0].strip() == 'PT', f"Incorrect max_value is {results[0][0].strip()}. Correct is PT"
        assert results[0][1].strip() == 'BOX', f"Incorrect min_value is {results[0][1].strip()}. Correct is BOX"
