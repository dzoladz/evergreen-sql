/* Derek C. Zoladz
 * Evergreen 3.0.x
 *
 * List TCNs with multiple 245 $a in bib record
 */
SELECT tcn_value AS "TCN Value"
FROM biblio.record_entry
WHERE id IN (
	SELECT record
	FROM metabib.real_full_rec
	WHERE tag = '245'
	AND subfield = 'a'
	GROUP BY record
	HAVING COUNT(*) > 1
)
AND deleted IS FALSE
ORDER BY tcn_value ASC;