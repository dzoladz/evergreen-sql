-- find stale holds

select *
from action.hold_request ahold
inner join actor.usr ausr on ausr.id = ahold.usr
where ahold.request_time > (now() - INTERVAL '200 days')
and ahold.capture_time is NULL
and ahold.expire_time is NULL
and ahold.cancel_time is NULL;