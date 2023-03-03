WITH
	json_string AS
	(
		SELECT '[{"employee_id": "5181816516151", "department_id": "1", "class": "src\bin\comp\json"}, {"employee_id": "925155", "department_id": "1", "class": "src\bin\comp\json"}, {"employee_id": "815153", "department_id": "2", "class": "src\bin\comp\json"}, {"employee_id": "967", "department_id": "", "class": "src\bin\comp\json"}]' [str]
	)
	, parsed_string as
	(
		SELECT CAST(
					NULLIF(
							SUBSTRING(
									[str]
									, CHARINDEX('employee_id', [str])+ 15
									, CHARINDEX('"', SUBSTRING([str], CHARINDEX('employee_id', [str])+ 15, len([str]))) - 1
									 ), ''
						  ) AS BIGINT
					) AS employee_id
			   ,CAST(
					NULLIF(
							SUBSTRING(
									[str]
									, CHARINDEX('department_id', [str])+ 17
									, CHARINDEX('"', SUBSTRING([str], CHARINDEX('department_id', [str])+ 17, len([str]))) - 1
									 ), ''
						  ) AS INT
					) AS department_id
			   ,SUBSTRING([str], CHARINDEX('}', [str]) +1 , (LEN([str]) - (CHARINDEX('}', [str])))) AS new_str
		FROM json_string
		UNION ALL
		SELECT CAST(
					NULLIF(
							SUBSTRING(
									new_str
									, CHARINDEX('employee_id', new_str)+ 15
									, CHARINDEX('"', SUBSTRING(new_str, CHARINDEX('employee_id', new_str)+ 15, len(new_str))) - 1
									 ), ''
						  ) AS BIGINT
					) AS employee_id
			   ,CAST(
					NULLIF(
							SUBSTRING(
									new_str
									, CHARINDEX('department_id', new_str)+ 17
									, CHARINDEX('"', SUBSTRING(new_str, CHARINDEX('department_id', new_str)+ 17, len(new_str))) - 1
									 ), ''
						  ) AS INT
					) AS department_id
			   ,SUBSTRING(new_str, CHARINDEX('}', new_str) +1 , (LEN(new_str) - (CHARINDEX('}', new_str)))) AS new_str
		FROM parsed_string
		WHERE LEN(new_str) > 1
	)
SELECT employee_id,
		department_id
FROM parsed_string;
