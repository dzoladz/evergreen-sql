-- list items (barcodes) missing circulcation modifiers by library (org_unit)
SELECT aou.name AS "Owning Library",
	b.id as "TCN", 
	cn.label as "Call Number", 
	c.barcode AS "Barcode", 
	xpath('//m:datafield[@tag="245"]/m:subfield[@code="a"]/text()', b.marc::xml, ARRAY[ARRAY['m','http://www.loc.gov/MARC21/slim']]) as "Title", 
	'Not Assigned' as "Circulation Modifier"
  FROM biblio.record_entry b
	INNER JOIN asset.call_number cn ON cn.record=b.id
	INNER JOIN asset.copy c ON c.call_number=cn.id
	INNER JOIN actor.org_unit aou on aou.id=cn.owning_lib
  WHERE b.deleted=FALSE
	AND c.deleted=FALSE
	AND b.id != -1
	AND c.circ_modifier IS NULL
  ORDER BY aou.name, c.barcode;