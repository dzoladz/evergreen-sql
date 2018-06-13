-- Evergreen 3.0
-- Count bibs, exclude deleted and ODL records

SELECT(
SELECT count(id)
FROM biblio.record_entry
WHERE deleted = 'false')
- (SELECT count(id)
FROM biblio.record_entry
WHERE source = '101') -- Ohio Digital Library Bib Source
;