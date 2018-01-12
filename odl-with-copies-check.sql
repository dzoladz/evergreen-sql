/* Consortium of Ohio Libraries
 * Version: Evergreen 3.0
 * 
 * Description: 
 * Several checks to review TCNs from Ohio Digital Library with copies attached.
 * Ohio Digital Library records, as electronic materials, should not have items attached 
 *
 * Note: 
 * Ohio Digital Library records are the only Overdrive records in the database
 * This check should be executed monthly
 */


-- 049 $aohia - check
SELECT
	bre.tcn_value AS "TCN",
	rmsr.title AS "Title"
FROM asset.copy acopy
	LEFT OUTER JOIN asset.call_number acall ON (acopy.call_number = acall.id)
	LEFT OUTER JOIN biblio.record_entry bre1 ON (acall.record = bre1.id)
	LEFT OUTER JOIN reporter.materialized_simple_record rmsr ON (bre1.id = rmsr.id)
	LEFT OUTER JOIN metabib.full_rec mbfr ON (bre1.id = mbfr.record)
	LEFT OUTER JOIN biblio.record_entry bre ON (mbfr.record = bre.id)
WHERE ((mbfr.tag) IS NULL OR mbfr.tag = '049')
	AND ((mbfr.value) IS NULL OR mbfr.value = 'ohia')
	AND ((mbfr.subfield) IS NULL OR mbfr.subfield = 'a')
	AND acopy.deleted = 'f'
GROUP BY 1, 2
ORDER BY bre.tcn_value ASC, rmsr.title ASC;


-- 049 $asrba - check
SELECT
	bre.tcn_value AS "TCN",
	rmsr.title AS "Title"
FROM asset.copy acopy
	LEFT OUTER JOIN asset.call_number acall ON (acopy.call_number = acall.id)
	LEFT OUTER JOIN biblio.record_entry bre1 ON (acall.record = bre1.id)
	LEFT OUTER JOIN reporter.materialized_simple_record rmsr ON (bre1.id = rmsr.id)
	LEFT OUTER JOIN metabib.full_rec mbfr ON (bre1.id = mbfr.record)
	LEFT OUTER JOIN biblio.record_entry bre ON (mbfr.record = bre.id)
WHERE ((mbfr.tag) IS NULL OR mbfr.tag = '049')
	AND ((mbfr.value) IS NULL OR mbfr.value = 'srba')
	AND ((mbfr.subfield) IS NULL OR mbfr.subfield = 'a')
	AND acopy.deleted = 'f'
GROUP BY 1, 2
ORDER BY bre.tcn_value ASC, rmsr.title ASC;


-- 049 $bautogen - check
SELECT
	bre.tcn_value AS "TCN",
	rmsr.title AS "Title"
FROM asset.copy acopy
	LEFT OUTER JOIN asset.call_number acall ON (acopy.call_number = acall.id)
	LEFT OUTER JOIN biblio.record_entry bre1 ON (acall.record = bre1.id)
	LEFT OUTER JOIN reporter.materialized_simple_record rmsr ON (bre1.id = rmsr.id)
	LEFT OUTER JOIN metabib.full_rec mbfr ON (bre1.id = mbfr.record)
	LEFT OUTER JOIN biblio.record_entry bre ON (mbfr.record = bre.id)
WHERE ((mbfr.tag) IS NULL OR mbfr.tag = '901')
	AND ((mbfr.value) IS NULL OR mbfr.value = 'autogen')
	AND ((mbfr.subfield) IS NULL OR mbfr.subfield = 'b')
	AND acopy.deleted = 'f'
GROUP BY 1, 2
ORDER BY bre.tcn_value ASC, rmsr.title ASC;