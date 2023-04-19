from connection import db_connection
from functions import get_data_from_db, get_max_min_from_db


def test_documentlevel_range_in_0_1_2(db_connection):
    for result in get_data_from_db(db_connection, table="[Production].[Document]", columns="[DocumentLevel]"):
        assert result[0] in [0, 1, 2], f"DocumentLevel value {result[0]} is not in the expected range"


def test_owner_between_217_and_220(db_connection):
    results = get_data_from_db(db_connection, table="[Production].[Document]", where="[Owner] not between 217 and 220")
    assert len(results) == 0, f"Owners out of range for {len(results)} records"


def test_rowguid_len_not_equal_36(db_connection):
    results = get_data_from_db(db_connection, table="[Person].[Address]", where="LEN(rowguid) != 36")
    assert len(results) == 0, f"Len of rowguid is incorrect for {len(results)} records"


def test_no_modifieddate_in_future(db_connection):
    results = get_data_from_db(db_connection, table="[Person].[Address]", where="ModifiedDate > CURRENT_TIMESTAMP")
    assert len(results) == 0, f"ModifiedDate column have future date for {len(results)} records"


def test_unitmeasurecode_doesnt_contain_null(db_connection):
    results = get_data_from_db(db_connection, table="[Production].[UnitMeasure]", where="UnitMeasureCode is null")
    assert len(results) == 0, f"UnitMeasureCode is null for {len(results)} records"


def test_min_max_value_of_unitmeasurecode(db_connection):
    query = "SELECT MAX(UnitMeasureCode) as max_value, MIN(UnitMeasureCode) as min_value " \
            "FROM [Production].[UnitMeasure];"
    cursor = db_connection.cursor()
    cursor.execute(query)
    results = get_max_min_from_db(db_connection, table="[Production].[UnitMeasure]",column="UnitMeasureCode")
    assert results[0][0].strip() == 'PT', f"Incorrect max_value is {results[0][0].strip()}. Correct is PT"
    assert results[0][1].strip() == 'BOX', f"Incorrect min_value is {results[0][1].strip()}. Correct is BOX"
