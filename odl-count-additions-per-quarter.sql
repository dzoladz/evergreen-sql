/* Consortium of Ohio Libraries
 * Version: Evergreen 3.0
 * 
 * Description: 
 * Count the number of Ohio Digital Library items added during the previous quarter
 *
 * Note: 
 * Ohio Digital Library records are the only Overdrive records in the database
 * Written to be executed quarterly
 */

SELECT
	count(bre.tcn_value)
FROM biblio.record_entry bre
	INNER JOIN metabib.real_full_rec mrfr ON (bre.id = mrfr.record)
WHERE (bre.source = '101') 
	AND (bre.create_date BETWEEN date_trunc('month', now()) - interval '3 month' 
		AND date_trunc('month', now()))
	AND mrfr.tag = '856'
	AND mrfr.value like '%overdrive%'
	AND deleted IS FALSE
;