-- List circulation modifiers in use at a given library
-- Useful for preparing circulation policy changes
SELECT distinct(ac.circ_modifier) AS "Circulation Modifiers"
FROM asset.copy ac
	JOIN actor.org_unit aou ON ac.circ_lib = aou.id
WHERE
-- Given the circulation policies for the following modifiers, what other modifiers are in use? 
-- ac.circ_modifier not in ('Equipment', 'Movie', 'Serial') 
-- AND
	aou.name ~* 'worch' -- set library
	AND ac.deleted = 'f'
;