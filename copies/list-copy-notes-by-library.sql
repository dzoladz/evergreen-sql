/* Consortium of Ohio Libraries
 * Version: Evergreen 3.0
 *
 * Description:
 * List the copy notes assigned to items at a specific library
 */

SELECT 
-- * 
	anote.id AS "Copy Note ID", 
	aunit.name AS "Library",
	acopy.barcode AS "Item Barcode",
	acall.label AS "Call Number",
	aloc.name AS "Shelving Location",
	anote.pub AS "Public Note?",
	anote.title AS "Copy Note Title",
	anote.value AS "Copy Note Value"
FROM asset.copy acopy
	INNER JOIN asset.copy_note anote ON anote.owning_copy = acopy.id
	INNER JOIN asset.call_number acall ON acall.id = acopy.call_number
	INNER JOIN actor.org_unit aunit ON acall.owning_lib = aunit.id
	INNER JOIN asset.copy_location aloc ON aloc.id = acopy.location
WHERE acall.owning_lib = '108' -- mt. gilead (107 parent)
ORDER BY acopy.barcode ASC;