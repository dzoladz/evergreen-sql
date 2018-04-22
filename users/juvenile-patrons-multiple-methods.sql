/* Evergreen 3.0
 *
 * Description: 
 * Identify patron records in permissions group 'Patrons' with Juvenile Flag = True
 * between a date range, or by age
 *
 */
SELECT *
FROM actor.usr
WHERE 
	-- home_ou = '118' -- J.R. Clarke Library
	-- profile = '2'
	-- juvenile = 't'
	-- dob BETWEEN '1900-01-01' and '2002-01-01'
    dob > now() - '15 years'::interval -- years before today
    AND deleted = 'f'
ORDER BY dob ASC
;