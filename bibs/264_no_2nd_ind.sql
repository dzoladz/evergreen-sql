SELECT tcn_value
FROM biblio.record_entry
WHERE tcn_value::integer IN (
	SELECT distinct(record)
	FROM metabib.real_full_rec
	WHERE tag = '264'
		AND ind2 = ' '
	)
AND deleted = 'false'
ORDER BY tcn_value ASC
;