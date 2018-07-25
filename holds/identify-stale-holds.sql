-- find stale holds

SELECT
--ahold.id AS "Hold ID",
to_char(ahold.request_time, 'yyyy-mm-dd HH:MI:SS') AS "Request Time",
ahold.frozen AS "Suspended?",
ahold.hold_type AS "Hold Type",
--ahold.pickup_lib AS "Pickup Library",
--ausr.home_ou AS "Home Library",
aorg.name AS "Patron Home Library",
ausr.usrname AS "Patron Barcode",
substring(ausr.first_given_name from 1 for 1) AS "Patron First Initial",
ausr.family_name AS "Patron Last Name",
ARRAY_TO_STRING(
    XPATH('//marc:datafield[@tag="245"][1]/marc:subfield[@code="a" or @code="b"]/text()',
      bre.marc::XML, ARRAY[ARRAY['marc', 'http://www.loc.gov/MARC21/slim']]
    ),
    ' '
  ) AS "Title"
FROM action.hold_request ahold -- hold records
	INNER JOIN actor.usr ausr ON ausr.id = ahold.usr -- patron records
	INNER JOIN biblio.record_entry bre ON bre.tcn_value = ahold.target::text -- title from 245a
	INNER JOIN actor.org_unit aorg ON aorg.id = ausr.home_ou -- org unit names
WHERE ahold.request_time < (now() - INTERVAL '120 days')
	AND ahold.hold_type = 'T' -- title-level holds
	AND ahold.capture_time IS NULL -- never captured
	AND (ahold.expire_time > now() -- expires at future date
		OR ahold.expire_time IS NULL) -- or does not expire
	AND fulfillment_time IS NULL -- remains unfulfilled
	AND ahold.cancel_time IS NULL -- hold not canceled by patron/staff
ORDER BY ahold.request_time ASC
;