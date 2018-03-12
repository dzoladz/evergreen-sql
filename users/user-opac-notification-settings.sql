/* Consortium of Ohio Libraries
 * Version: Evergreen 3.0
 *
 * Description:
 * View OPAC notification settings
 */
 
SELECT *
FROM actor.usr_setting asetting
INNER JOIN actor.usr ausr ON ausr.id = asetting.usr
WHERE asetting.name ~* 'opac.hold_notify'
limit 5;