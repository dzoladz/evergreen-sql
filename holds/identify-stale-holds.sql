-- find stale holds

select *
from action.hold_request
where request_time > (now() - INTERVAL '200 days')
and capture_time is NULL
and expire_time is NULL
and cancel_time is NULL;