select 
-- *
count(distinct(acirc.id)) AS "Total Circs",
acn.label AS "Call Number",
ac.barcode AS "Barcode",
to_char(max(acirc.checkin_time), 'MM-DD-YYYY') AS "Last Checkin Time",
max(acirc.due_date) > now() AS "Checked Out?",
  ARRAY_TO_STRING(
    XPATH('//marc:datafield[@tag="245"][1]//text()',
      bre.marc::XML, ARRAY[ARRAY['marc', 'http://www.loc.gov/MARC21/slim']]
    ),
    ' '
  ) AS "Detailed Info"
from asset.copy ac
inner join asset.call_number acn ON ac.call_number = acn.id
inner join biblio.record_entry bre ON acn.record = bre.id
inner join action.circulation acirc ON ac.id = acirc.target_copy
where acn.owning_lib = '118'
	AND ac.circ_modifier = 'Movie'
	AND ac.deleted is false
group by acirc.target_copy, acn.label, ac.barcode, bre.marc
Order by "Total Circs" desc
-- limit 5
;