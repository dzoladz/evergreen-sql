-- Draft:: Identify Bibs with Volumes, but no copies

SELECT
	distinct(b.tcn_value) AS "TCN", 
	aou.name AS "Library", 
	to_char(a.last_delete_date, 'MM-DD-YYYY') AS "Delete Date",
	b.source AS "REMOVE, if source = 101"
FROM (SELECT 
		bre.id,
		MAX(dcp.edit_date) AS last_delete_date
			FROM biblio.record_entry bre
			JOIN asset.call_number cn ON (cn.record = bre.id)
			JOIN asset.copy dcp ON (cn.id = dcp.call_number)
		WHERE NOT bre.deleted
		GROUP BY bre.id
		HAVING SUM(CASE WHEN NOT dcp.deleted THEN 1 ELSE 0 END) = 0 
	  ) as "a"       
INNER JOIN biblio.record_entry AS "b" ON (a.id = b.id)
INNER JOIN asset.call_number acn ON (a.id = acn.record)
INNER JOIN actor.org_unit aou ON (acn.owning_lib = aou.id)
WHERE acn.deleted = 'f'
ORDER BY aou.name
