/*
 * Count items assigned to a copy location at a library
 * Do not show deleted items
 */
SELECT count(acopy.id) AS "Item Count",
	acl.name AS "Copy Location",
	aou.name AS "Library"
FROM asset.copy acopy
	JOIN asset.copy_location acl ON acl.id = acopy.location
	JOIN actor.org_unit aou ON acl.owning_lib = aou.id 
WHERE --acopy.location = '441'
	aou.name ~* 'cardington' -- Library
	AND acopy.deleted = 'f'
GROUP BY acl.name, aou.name
ORDER BY acl.name
;