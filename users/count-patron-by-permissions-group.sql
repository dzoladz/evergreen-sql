/* Consortium of Ohio Libraries
 * Version: Evergreen 3.0
 * 
 * Description: 
 * Count User Records Assigned to a Permissions Group by Home Library
 */
 
SELECT  
	pgt.name AS "Permission Group",
	count(au.profile) AS "# of Records"
FROM actor.usr au
	INNER JOIN permission.grp_tree pgt ON pgt.id = au.profile
WHERE au.home_ou = '118' -- J.R. Clarke
GROUP BY pgt.name;