-- EG version: 2.10
-- List Patron Information by Library using Alert Message
SELECT
	acard.barcode AS "Barcode",
	acard.active AS "Card Active?",
	ausr.first_given_name AS "First Name",
	ausr.second_given_name AS "Middle Name",
	ausr.family_name AS "Last Name",
	ausr.day_phone AS "Phone #",
	ausr.juvenile "Juvenile?",
	pgt.name AS "Permissions Group"
FROM actor.usr ausr
	INNER JOIN permission.grp_tree pgt ON pgt.id = ausr.profile
	INNER JOIN actor.card acard ON acard.id = ausr.card
WHERE ausr.alert_message = 'INDEFINITE LOAN'
	AND ausr.home_ou = '118' -- J.R. Clarke
	AND ausr.deleted = 'f';