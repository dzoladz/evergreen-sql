/* Consortium of Ohio Libraries
 * Version: Evergreen 3.0
 *
 * Description:
 * List permissions associated with a permissions group id
 * List all, or uncomment filter in query
 */
SELECT 
  pgt.id AS "Permission Group ID",
  pgt.name AS "Permission Group Profile",
  ppl.code AS "Permission Name", 
  ppl.description AS "Permission Description",  
  pgpm.depth AS "Depth", 
  pgpm.grantable AS "Grantable?"
FROM permission.perm_list ppl
  INNER JOIN permission.grp_perm_map pgpm ON pgpm.perm = ppl.id
  INNER JOIN permission.grp_tree pgt ON pgt.id = pgpm.grp
--WHERE pgt.name ~* 'local system' -- filter, case insensitive name is like
ORDER BY pgt.name, ppl.code ASC
;