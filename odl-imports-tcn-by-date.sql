/* 
Identify TCNs that have 'Overdrive' in the 856 
Note: Query can take upword of 5 minutes to complete for yearly ranges 
*/
SELECT *
FROM biblio.record_entry bre
INNER JOIN metabib.real_full_rec mrfr ON (bre.id = mrfr.record)
WHERE (bre.source = '1' OR bre.source is null) 
	AND bre.create_date > '2016-01-01'
	AND mrfr.tag = '856' 
	AND mrfr.value like '%overdrive%'
ORDER BY bre.create_date DESC
--Limit 5
;