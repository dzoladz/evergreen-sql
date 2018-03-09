/* Consortium of Ohio Libraries
 * Version: Evergreen 3.0
 * 
 * Description: 
 * Count Total Circs for DVDs, display title and subtitle
 */

SELECT 
-- *
COUNT(DISTINCT(acirc.id)) AS "Total Circs",
acn.label AS "Call Number",
ac.barcode AS "Barcode",
to_char(MAX(acirc.checkin_time), 'MM-DD-YYYY') AS "Last Checkin Time",
MAX(acirc.due_date) > now() AS "Checked Out?",
  ARRAY_TO_STRING(
    XPATH('//marc:datafield[@tag="245"][1]/marc:subfield[@code="a" or @code="b"]/text()',
      bre.marc::XML, ARRAY[ARRAY['marc', 'http://www.loc.gov/MARC21/slim']]
    ),
    ' '
  ) AS "Detailed Info"
FROM asset.copy ac
INNER JOIN asset.call_number acn ON ac.call_number = acn.id
INNER JOIN biblio.record_entry bre ON acn.record = bre.id
INNER JOIN action.circulation acirc ON ac.id = acirc.target_copy
WHERE acn.owning_lib = '118'
	AND ac.circ_modifier = 'Movie'
	AND ac.deleted is false
GROUP BY acirc.target_copy, acn.label, ac.barcode, bre.marc
ORDER BY "Total Circs" DESC
-- limit 5
;