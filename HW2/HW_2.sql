IF OBJECT_ID ( 'P_GetStatistics', 'P' ) IS NOT NULL   
    DROP PROCEDURE P_GetStatistics;  
GO  
CREATE PROCEDURE P_GetStatistics 
	(@p_DatabaseName NVARCHAR(MAX) = NULL,  @p_SchemaName NVARCHAR(MAX) = NULL, @p_TableName NVARCHAR(MAX) = NULL)
AS  
BEGIN
SET NOCOUNT ON
DECLARE @Query VARCHAR(MAX)
DECLARE @Query_db VARCHAR(MAX)
SET @Query_db='USE ' + @p_DatabaseName + '; '
DECLARE @sql NVARCHAR(MAX) =''
DECLARE @sql_top NVARCHAR(MAX) =''
IF OBJECT_ID ('tempdb..#AllInfo') IS NOT NULL DROP TABLE #AllInfo
IF OBJECT_ID ('tempdb..#ColumnsList') IS NOT NULL DROP TABLE #ColumnsList
IF OBJECT_ID ('tempdb..#TopInfo') IS NOT NULL DROP TABLE #TopInfo

CREATE TABLE #AllInfo (DatabaseName sysname, SchemaName sysname, TableName sysname, TableTotalRowCount int
					, ColumnName sysname , DataType sysname,  CountOfDistinctValue int, CountOfNullValues int
					, CountOfFullUpperCase int , CountOfFullLowerCase int , CountOfRowsWithUnprinatableChar int, MinValue varchar(max), MaxValue varchar(max))
CREATE TABLE #ColumnsList (DatabaseName sysname, TableSchema sysname, TableName sysname, ColumnName sysname , DataType sysname)
CREATE TABLE #TopInfo (TableSchema sysname, TableName sysname, ColumnName sysname, MostUsedValue varchar(max), CountTopValue int)

SET @Query = 'SELECT table_catalog, Table_Schema, Table_Name, Column_name, data_type FROM INFORMATION_SCHEMA.COLUMNS
				WHERE TABLE_SCHEMA = ' + CHAR(39) + @p_SchemaName + CHAR(39);

IF @p_TableName <> '%'
	SET @Query = @Query + ' and table_name = ' + CHAR(39) + @p_TableName + CHAR(39);
SET @Query = @Query_db + @Query

INSERT INTO #ColumnsList
EXECUTE(@Query)

SELECT @sql += 'SELECT  '''+DatabaseName+''' AS DatabaseName ,
				'''+TableSchema+''' AS SchemaName ,
				'''+TableName+''' AS TableName ,
				COUNT(*) AS TableTotalRowCount,
				'''+ColumnName+''' AS ColumnName,  
				'''+DataType+''' AS DataType,
				COUNT(DISTINCT ' +ColumnName+') AS CountOfDistinctValue,
				SUM(CASE WHEN '+ColumnName+' IS NULL THEN 1 ELSE 0 END) AS CountOfNullValues,
				
				SUM(CASE WHEN CAST('+ColumnName+' AS binary) = CAST(UPPER('+ColumnName+') AS binary) THEN 1 ELSE 0 END) AS CountOfFullUpperCase,
				SUM(CASE WHEN CAST('+ColumnName+' AS binary) = CAST(LOWER('+ColumnName+') AS binary) THEN 1 ELSE 0 END) AS CountOfFullLowerCase,
				SUM(CASE WHEN LEN(TRIM(CHAR(32)+CHAR(9)+CHAR(10)+CHAR(13)+CHAR(160) FROM CAST('+ColumnName+' AS varchar))) = LEN(CAST('+ColumnName+' AS varchar)) 
				    THEN 0 ELSE 1 END 
					) AS CountOfRowsWithUnprinatableChar, 
				MIN('+ColumnName+') AS MinValue,
				MAX('+ColumnName+') AS MaxValue
				FROM '+QUOTENAME(TableSchema)+'.'+QUOTENAME(TableName)+';'+ CHAR(10)
 FROM #ColumnsList


 SET @sql = @Query_db+@sql
 INSERT INTO #AllInfo
  EXECUTE(@sql)

SELECT @sql_top += 'SELECT TOP 1 '''+TableSchema+''' AS SchemaName ,
							'''+TableName+''' AS TableName ,
						 '''+ColumnName+''' AS ColumnName,
						 '+ColumnName+' AS MostUsedValue,
						COUNT('+ColumnName+') AS CountTopValue 
				FROM '+QUOTENAME(TableSchema)+'.'+QUOTENAME(TableName)+'
				GROUP BY 
					'+ColumnName+'
				ORDER BY 
					CountTopValue DESC;'+ CHAR(10)
 FROM #ColumnsList;

 SET @sql_top = @Query_db+@sql_top
 INSERT INTO #TopInfo
   EXECUTE(@sql_top);


 SELECT ai.*, ti.MostUsedValue, (CAST(ti.CountTopValue AS float)/CAST(ai.TableTotalRowCount AS float) * 100) AS PercentageOfRowsWithMostUsedValue
 FROM #AllInfo ai
 INNER JOIN #TopInfo ti
 ON ai.SchemaName = ti.TableSchema 
   AND ai.TableName = ti.TableName 
   AND ai.ColumnName = ti.ColumnName 

  DROP TABLE #AllInfo
  DROP TABLE #ColumnsList
  DROP TABLE #TopInfo

 END;

EXEC P_GetStatistics 'TRN','hr','%';


EXEC P_GetStatistics 'AdventureWorks2017','Production','Location';