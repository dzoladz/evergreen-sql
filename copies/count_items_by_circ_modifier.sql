/* Consortium of Ohio Libraries
 * Version: Evergreen 3.1
 * 
 * Description: 
 * List the number of items that are assigned a specific circulation modifier at a library
 * 
 * Note: Filters out deleted records. Filters for Item Status as well.
 */

SELECT ac.circ_modifier, count(ac.barcode)
/*	aou.name AS "Library",
--	ac.barcode AS "Barcode",
--	ac.circ_modifier AS "Circ Modifier",
--	cstatus.name AS "Status",
--	ac.opac_visible AS "Item - OPAC Visible?",
--	ac.holdable AS "Item - Holdable?",
--	ac.alert_message AS "Alert Message",
--	acl.name AS "Shelving Location",
--	acl.opac_visible AS "Shelving Location - OPAC Visible?",
--	acl.holdable AS "Shelving Location - Holdable?"
*/
FROM asset.copy ac
	JOIN asset.copy_location acl ON ac.location = acl.id
	JOIN actor.org_unit aou ON ac.circ_lib = aou.id
	JOIN config.copy_status cstatus ON ac.status = cstatus.id 
WHERE aou.name ~* 'german' -- SET LIBRARY
	--AND ac.circ_modifier ~* 'jbook' -- SET CIRCULATION MODIFIER
	AND cstatus.name NOT IN ('Lost', 'Discard/Weed','Mending') -- Status Filters
	AND ac.deleted = 'f'
GROUP BY ac.circ_modifier
;