/* Consortium of Ohio Libraries
 * Version: Evergreen 3.0
 * 
 * Description: 
 * Identify TCNs that have 'Overdrive' in the 856, but the bib source is NOT set to 101 'Ohio Digital Library'
 *
 * Note: 
 * Ohio Digital Library records are the only Overdrive records in the database
 * Written to be executed quarterly
 */

SELECT 
	bre.tcn_value
FROM biblio.record_entry bre
	INNER JOIN metabib.real_full_rec mrfr ON (bre.id = mrfr.record)
WHERE (bre.source != '101' OR bre.source is null) 
	AND (bre.create_date BETWEEN date_trunc('month', now()) - interval '3 month' 
		AND date_trunc('month', now()))
	-- AND bre.create_date >= '2017-07-01' -- After a specific date
	-- AND (bre.create_date BETWEEN '2017-01-01' AND '2017-03-01') -- Between a date range
	AND mrfr.tag = '856'
	AND mrfr.value like '%overdrive%'
	AND deleted IS FALSE
ORDER BY bre.create_date DESC
;
