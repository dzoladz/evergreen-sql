/* Consortium of Ohio Libraries
 * Version: Evergreen 3.0
 * 
 * Description: 
 * List Shortname of Organizational Units
 */
SELECT 
	shortname AS "Shortname ID", 
	name AS "Library Name"
FROM actor.org_unit
WHERE ou_type = '3' -- main branch
;