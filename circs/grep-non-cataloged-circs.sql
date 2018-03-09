-- Identify Non-cataloged Circulations by Non-cataloged Type
SELECT	au.first_given_name AS "First Name", 
	au.family_name AS "Last Name", 
	ancc.circ_time AS "Checkout Date/Time"
FROM action.non_cataloged_circulation ancc
	JOIN actor.usr au ON au.id = ancc.patron
WHERE ancc.circ_lib = '4' -- Community Library (Sunbury)
	AND ancc.item_type = '101' -- 'microfilm' from config.non_cataloged_type
order by circ_time desc;