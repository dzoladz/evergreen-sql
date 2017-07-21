-- list items (barcodes) missing circulcation modifiers by library (org_unit)
SELECT ou.name AS "Library", 
	b.id as "TCN", 
	cn.label as "Call Number", 
	c.barcode AS "Barcode", 
	xpath('//m:datafield[@tag="245"]/m:subfield[@code="a"]/text()', b.marc::xml, ARRAY[ARRAY['m','http://www.loc.gov/MARC21/slim']]) as "Title", 
	'Not Assigned' as "Circulation Modifier"
  FROM biblio.record_entry b
	INNER JOIN asset.call_number cn ON cn.record=b.id
	INNER JOIN asset.copy c ON c.call_number=cn.id
	INNER JOIN actor.org_unit ou on ou.id=c.circ_lib
  WHERE b.deleted=FALSE
	AND c.deleted=FALSE
	AND b.id != -1
	AND c.circ_modifier IS NULL
  ORDER BY ou.name, c.barcode;