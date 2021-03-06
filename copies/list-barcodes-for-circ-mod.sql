/* Consortium of Ohio Libraries
 * Version: Evergreen 3.0
 *
 * Description:
 * List the barcodes for items having a specific circulation modifer by library and shelving location
 * Useful for preparing circulation policy changes
 */

SELECT 
	aou.name AS "Library",
	ac.barcode AS "Barcode",
	ac.circ_modifier AS "Circ Modifier",
	cstatus.name AS "Status",
	ac.opac_visible AS "Item - OPAC Visible?",
	ac.holdable AS "Item - Holdable?",
	ac.alert_message AS "Alert Message",
	acl.name AS "Shelving Location",
	acl.opac_visible AS "Shelving Location - OPAC Visible?",
	acl.holdable AS "Shelving Location - Holdable?"
FROM asset.copy ac
	JOIN asset.copy_location acl ON ac.location = acl.id
	JOIN actor.org_unit aou ON ac.circ_lib = aou.id
	JOIN config.copy_status cstatus ON ac.status = cstatus.id 
WHERE ac.circ_modifier ~* 'new book' -- SET CIRCULATION MODIFIER
	AND aou.name ~* 'galion' -- SET LIBRARY
	AND cstatus.name NOT IN ('Lost', 'Discard/Weed','Mending') -- Status Filters
	AND ac.deleted = 'f'
ORDER BY ac.edit_date DESC -- sort most recently added items to top
-- limit 10
;