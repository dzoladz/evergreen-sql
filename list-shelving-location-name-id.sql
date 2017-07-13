-- list shelving location name and id by library with org unit
SELECT aou.name AS "Library (Org Unit)",
	aou.id AS "Org Unit ID",
	acl.name AS "Shelving Location Name",
	acl.id AS "Shelving Location ID" 
FROM asset.copy_location acl
	JOIN actor.org_unit aou ON aou.id = acl.owning_lib
ORDER BY aou.name, acl.name;