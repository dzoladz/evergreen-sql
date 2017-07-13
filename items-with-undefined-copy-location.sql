-- items assigned to copy location COOL Stacks
-- This is an undefined copy location, no one should be using it
SELECT ou.name AS "Library", 
	b.id AS "TCN", 
	cn.label AS "Call Number", 
	c.barcode AS "Barcode", 
	xpath('//m:datafield[@tag="245"]/m:subfield[@code="a"]/text()', b.marc::xml, ARRAY[ARRAY['m','http://www.loc.gov/MARC21/slim']]) AS "Title", 
	'Copy Location ''Stacks'' is undefined' AS "Issue"
  FROM biblio.record_entry b
	INNER JOIN asset.call_number cn ON cn.record=b.id
	INNER JOIN asset.copy c ON c.call_number=cn.id
	INNER JOIN actor.org_unit ou on ou.id=c.circ_lib
  WHERE b.deleted=FALSE
	AND c.deleted=FALSE
	AND b.id != -1
	AND c.location = 1 -- i.e. Stacks
  ORDER BY ou.name, c.barcode;