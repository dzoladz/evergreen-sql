-- Number of Records Without Subject Headings
SELECT COUNT(DISTINCT b.id) AS number_of_records_without_subject_headings
  FROM biblio.record_entry b
  INNER JOIN asset.call_number cn ON cn.record=b.id
  INNER JOIN asset.copy c ON c.call_number=cn.id
  WHERE b.deleted=FALSE
  -- which tags?
	AND b.marc NOT LIKE '%tag="600%'
	AND b.marc NOT LIKE '%tag="610%'
	AND b.marc NOT LIKE '%tag="611%'
	AND b.marc NOT LIKE '%tag="630%'
	AND b.marc NOT LIKE '%tag="650%'
	AND b.marc NOT LIKE '%tag="651%'
  -- shelving locations to ignore?
	-- AND c.location !='721' -- 2nd Floor, Arcanum Library
	-- AND c.location !='652' -- Nonfiction, Blanchester Library
	-- AND c.location !='116' -- Juvenile Fiction, Community Library (Sunbury)
  AND cn.label NOT LIKE 'ILL%';