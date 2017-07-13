/*
Consortium of Ohio Libraries
Identify TCNs for Quarterly Authority Process with Backstage Library Works

Note: Execute query during the month following the end of each quarter
*/

((
SELECT DISTINCT 
	bre1.tcn_value AS "TCN" 
  FROM biblio.record_entry bre1
  INNER JOIN metabib.real_full_rec mrfr1 ON bre1.id = mrfr1.record
  WHERE
    bre1.edit_date BETWEEN date_trunc('month', now()) - interval '3 month' 
    AND date_trunc('month', now()) 
    AND bre1.deleted = 'f'
) EXCEPT (
SELECT DISTINCT 
	bre2.tcn_value AS "TCN" 
  FROM biblio.record_entry bre2
  INNER JOIN metabib.real_full_rec mrfr2 ON bre2.id = mrfr2.record
  WHERE
    (
    (mrfr2.tag = '040' AND mrfr2.value ~ 'utorblw') 
     OR (mrfr2.tag = '856' AND mrfr2.value ~ 'overdrive') 
     OR (mrfr2.tag = '990' AND mrfr2.value ~ 'brief') 
     OR (mrfr2.tag = '049' AND mrfr2.value ~ 'ohia') 
     OR (mrfr2.tag = '049' AND mrfr2.value ~ 'srba') 
     OR (mrfr2.tag = '901' AND mrfr2.subfield = 'b' AND mrfr2.value ~ 'autogen')
     ) 
     AND bre2.deleted = 'f'
)) ORDER BY 1 ASC;