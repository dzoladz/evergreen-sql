-- Evergreen 2.10 
-- Identify Patron of Failed SMS Notifications
-- If Default SMS Number is Not Set in actor.usr

SELECT
	usrname AS Username, 
	first_given_name AS "First Name", 
	second_given_name AS "Middle Name", 
	family_name AS "Surname", 
	day_phone AS "Daytime Phone", 
	evening_phone AS "Evening Phone", 
	other_phone AS "Other Phone", 
	deleted AS "Is Deleted?", 
	juvenile AS "Is Juvenile?"
	-- *
FROM actor.usr
	WHERE id = (
		SELECT usr
		FROM actor.usr_setting
		WHERE name ~* 'sms'
			AND value ~* '6145709847'); -- try with hyphenation, if fails
	