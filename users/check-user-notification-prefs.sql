-- User Notification Preferences, SMS Notifications Set?
SELECT
	aorg.name AS "Library",
	count(ausr.id) AS "SMS Notifications"
FROM actor.card acard
	INNER JOIN actor.usr ausr ON acard.id = ausr.card
	INNER JOIN actor.usr_setting asetting ON asetting.usr = ausr.id
	INNER JOIN actor.org_unit aorg ON aorg.id = ausr.home_ou
WHERE 
asetting.name = 'opac.hold_notify'
-- AND ausr.home_ou = '116' # Select a Specific Library
AND asetting.value ~* 'sms'
GROUP BY aorg.name
ORDER BY aorg.name asc
;