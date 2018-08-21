/*
 * Lists Item Barcodes in a Copy Location
 * Useful for Call Number Clean-up Projects
 */
SELECT 
-- *
	aprefix.label AS "Prefix Label",
	acall.label AS "Call Number Value",
	acopy.barcode As "Item Barcode",
	aloc.name AS "Copy Location",
	acopy.deleted AS "Deleted?"
FROM asset.copy acopy
	JOIN asset.call_number acall ON acall.id = acopy.call_number
	JOIN asset.copy_location aloc ON aloc.id = acopy.location
	JOIN asset.call_number_prefix aprefix ON aprefix.id = acall.prefix
WHERE acopy.location = '441' -- Fiction @ Cardington
	AND acopy.deleted = 'f'
ORDER BY acall.prefix, acall.label ASC
;