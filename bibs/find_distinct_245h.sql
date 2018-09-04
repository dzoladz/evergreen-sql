/* Derek C. Zoladz
 * Evergreen 3.0.x
 *
 * List distinct 245 $h values and list TCNs
 * NOTE: Removed values for any deleted records
 */
SELECT
	distinct(mrfr.value) AS "245 $h",
	count(mrfr.record),
	array_agg(mrfr.record) AS "TCNs"
FROM metabib.real_full_rec mrfr
JOIN biblio.record_entry bre ON mrfr.record=bre.tcn_value::integer
WHERE bre.deleted = FALSE
	AND mrfr.tag = '245'
	AND subfield = 'h'
GROUP BY value
HAVING count(mrfr.record) < 16
ORDER BY count ASC
;