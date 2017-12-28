/* Consortium of Ohio Libraries
 * Version: Evergreen 3.0
 *
 * Description:
 * List Permissions that have been INDIVIDUALLY granted to a user
 * Search by username
 */
SELECT ppl.code AS "Permission Name", 
	ppl.description AS "Description", 
	pupm.depth AS "Depth", 
	pupm.grantable AS "Grantable?", 
	au.usrname AS "User Name", 
	au.first_given_name AS "First Name", 
	au.family_name AS "Last Name", 
	au.home_ou AS "Org Unit ID"
FROM actor.usr au
   INNER JOIN permission.usr_perm_map pupm ON pupm.usr = au.id
   INNER JOIN permission.perm_list ppl ON ppl.id = pupm.perm
   where au.usrname in ('USER_X', 'USER_Y') -- sub usernames from USER_X, USER_Y
ORDER BY ppl.code ASC
;