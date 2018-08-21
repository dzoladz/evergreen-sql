/*
 * Finding Call Number Prefixes
 * Count items assigned a call number prefix by Copy Location and Library
 */
SELECT aou.name AS "Library",
	acl.name AS "Copy Location",
	aprefix.label AS "Prefix",
	count(acopy.id) AS "Item Count"   
FROM asset.copy acopy
JOIN asset.copy_location acl ON acl.id = acopy.location
JOIN actor.org_unit aou ON acl.owning_lib = aou.id
JOIN asset.call_number acall ON acall.id = acopy.call_number
JOIN asset.call_number_prefix aprefix ON aprefix.id = acall.prefix
WHERE acl.name = 'Fiction' -- Requires Exact Name
--acopy.location = '441'
	AND aou.name ~* 'cardington'
	AND acopy.deleted = 'f'
GROUP BY acl.name, aou.name, aprefix.label
ORDER BY aprefix.label ASC
;