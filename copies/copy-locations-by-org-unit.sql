-- Copy locations by Organizational Unit
SELECT 
  acl.name AS "Shelving/Copy Location", 
  aou.name AS "Library"
FROM asset.copy_location acl
  INNER JOIN actor.org_unit aou ON acl.owning_lib = aou.id
WHERE acl.deleted = 'f'
ORDER BY aou.name ASC;