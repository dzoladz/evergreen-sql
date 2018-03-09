/* Derek C. Zoladz
 * Evergreen 2.10
 *
 * List TCNs without 260 and 264 fields
 * Populate 990 $a values in results for filtering
 */
SELECT DISTINCT b.id as "TCN", 
	ou.name as "Library", 
	cn.label as "Call Number", 
	c.barcode as "Barcode",
	array_to_string(
		xpath('//marc:datafield[@tag="245"][1]/marc:subfield[@code="a" or @code="b"]/text()', 
		b.marc::XML,
		ARRAY[ARRAY['marc', 'http://www.loc.gov/MARC21/slim']]), ' '
		) AS "Title",
		xpath('//m:datafield[@tag="990"]/m:subfield[@code="a"]/text()', b.marc::xml, ARRAY[ARRAY['m','http://www.loc.gov/MARC21/slim']])::VARCHAR as "990 $a Value"
FROM biblio.record_entry b
	INNER JOIN asset.call_number cn ON cn.record=b.id
	INNER JOIN asset.copy c ON c.call_number=cn.id
	INNER JOIN actor.org_unit ou ON ou.id=c.circ_lib
	INNER JOIN metabib.real_full_rec mrfr ON b.id=mrfr.record
WHERE b.deleted=FALSE
	AND b.marc NOT LIKE '%tag="260%'
	AND b.marc NOT LIKE '%tag="264%'
	-- add copy locations to remove from results
	-- AND c.location !=111 -- Sunbury 'MORE BOOK'
	-- AND c.location !=174 -- Germantown 'Interlibrary Loan'
	-- add text in Call Numbers to ignore
	-- AND cn.label NOT LIKE 'ILL%'
	AND b.id != -1
	AND c.deleted = false -- added to filter out copies that have been discarded
ORDER BY ou.name;