/* Derek C. Zoladz
 * Evergreen 3.0.x
 *
 * List distinct 245 $h values
 * NOTE: Includes deleted records to give a broader perspective of use
 */
SELECT distinct(value), count(record)
FROM metabib.real_full_rec
WHERE tag = '245'
	AND subfield = 'h'
GROUP BY value
ORDER BY value ASC
;