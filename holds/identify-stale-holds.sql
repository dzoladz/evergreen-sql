-- find stale holds
-- Add check for 'frozen' holds

SELECT *
FROM action.hold_request ahold
INNER JOIN actor.usr ausr ON ausr.id = ahold.usr
LEFT JOIN asset.copy acopy ON acopy.id = ahold.target
WHERE ahold.request_time > (now() - INTERVAL '200 days')
AND ahold.capture_time is NULL
AND ahold.expire_time is NULL
AND ahold.cancel_time is NULL;

