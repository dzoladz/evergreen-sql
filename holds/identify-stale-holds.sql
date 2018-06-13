-- find stale holds
-- Add check for 'frozen' holds

SELECT
-- *
ahold.id AS "Hold ID", ahold.request_time AS "Request Date/Time", ahold.frozen AS "Hold Frozen?",
ausr.usrname AS "Patron Barcode", ausr.first_given_name AS "Patron First Name", ausr.family_name AS "Patron Last Name"
--acopy.barcode AS "Item Barcode", acopy.deleted AS "Item Deleted"
FROM action.hold_request ahold
	INNER JOIN actor.usr ausr ON ausr.id = ahold.usr
	LEFT JOIN asset.copy acopy ON acopy.id = ahold.target
WHERE ahold.request_time < (now() - INTERVAL '120 days')
	AND ahold.capture_time is NULL -- hold not captured
	AND ahold.expire_time is NULL -- hold not expired
	AND ahold.cancel_time is NULL -- hold not canceled by patron/staff
ORDER BY ahold.request_time DESC
;

