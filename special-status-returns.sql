/* identify last 50 'returns' with special statuses at library*/
/* (CLAIMSRETURNED, MAXFINES, etc.) */

SELECT *
FROM action.circulation
WHERE checkin_time is null
    AND stop_fines != 'LOST'
    AND circ_lib = 4 -- org_unit id of library
ORDER BY due_date DESC
LIMIT 50;