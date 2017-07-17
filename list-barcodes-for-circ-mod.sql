-- List the barcodes for items having a specific circulation modifer by library and shelving location
-- Useful for preparing circulation policy changes
SELECT 
	aou.name AS "Library",
	ac.barcode AS "Barcode",
	ac.circ_modifier AS "Circ Modifier",
	ac.opac_visible AS "Item - OPAC Visible?",
	ac.alert_message AS "Alert Message",
	acl.name AS "Shevling Location",
	acl.opac_visible AS "Shelving Location - OPAC Visible?"
-- *
FROM asset.copy ac
	JOIN asset.copy_location acl ON ac.location = acl.id
	JOIN actor.org_unit aou ON ac.circ_lib = aou.id
WHERE ac.circ_modifier ~* 'equipment' -- set circ mod
	AND aou.name ~* 'sunbury' -- set library
	AND ac.deleted = 'f'
ORDER BY ac.edit_date DESC -- sort most recently added items to top
-- limit 10
;