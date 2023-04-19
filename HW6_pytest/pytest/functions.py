def get_data_from_db(db_connection, table, columns='*', where = None):
    query = "SELECT " + columns + " FROM " + table
    if where is not None:
        query = query + " WHERE " + where
    cursor = db_connection.cursor()
    cursor.execute(query)
    results = cursor.fetchall()
    return results


def get_max_min_from_db(db_connection, table, column, where = None):
    query = "SELECT MAX("+column+"), MIN("+column+ ") FROM " + table
    if where is not None:
        query = query + " WHERE " + where
    cursor = db_connection.cursor()
    cursor.execute(query)
    results = cursor.fetchall()
    return results

