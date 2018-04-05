/* Consortium of Ohio Libraries
 * Version: Evergreen 3.0
 * 
 * Description: 
 * List Permissions Groups, IDs, and Associated Record Counts
 * Or, Filter by Home Library
 */

SELECT pgt.id AS "Profile ID",
	pgt.name AS "Permission Group",
	count(au.profile) AS "# of Records"
FROM actor.usr au
	INNER JOIN permission.grp_tree pgt ON pgt.id = au.profile
--WHERE au.home_ou = '118' -- Or, specify a library J.R. Clarke
GROUP BY pgt.name, pgt.id
ORDER pgt.id;