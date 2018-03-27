-- Draft
-- Use to confirm notification setting for a hold
SELECT
--*
	ahold.request_time,
	ahold.capture_time,
	ahold.current_copy,
	ahold.request_lib,
	ahold.email_notify,
	ahold.phone_notify,
	ahold.sms_notify,
	ahold.sms_carrier,
	ausr.usrname AS "Account Placing Hold",
	requestor.usrname AS "Held for Account"
FROM action.hold_request ahold
	LEFT JOIN config.sms_carrier smscarrier ON ahold.sms_carrier = smscarrier.id
	INNER JOIN actor.usr ausr ON ausr.id = ahold.requestor
	INNER JOIN actor.usr requestor ON requestor.id = ahold.usr
WHERE ahold.id = '368228' -- hold ID;