/* 
Identify TCNs that have 'Overdrive' in the 856 
Note: Query can take upword of 5 minutes to complete for yearly ranges 
*/
SELECT 
	bre.tcn_value
	-- * -- if other value matches are needed, toggle
FROM biblio.record_entry bre
	INNER JOIN metabib.real_full_rec mrfr ON (bre.id = mrfr.record)
WHERE (bre.source = '1' OR bre.source is null) 
	AND bre.create_date >= '2017-01-01' -- After a specific date
	-- AND (bre.create_date BETWEEN '2017-01-01' AND '2017-03-01')
	AND mrfr.tag = '856'
	AND mrfr.value like '%overdrive%'
ORDER BY bre.create_date DESC
-- Limit 5
;