/* Consortium of Ohio Libraries
 * Version: Evergreen 3.0
 * 
 * Description: 
 * Output Library Settings Editor Values for the Consortium
 */

SELECT
	aorg.name AS "Library",
	cous.label AS "Setting Name",
	cous.description AS "Setting Description",
	asetting.name AS "Setting DB Name",
	asetting.value AS "Setting Value",
	aorg.shortname AS "Library Shortname",
	cous.grp AS "Associated Interface"
FROM actor.org_unit_setting asetting
	INNER JOIN actor.org_unit aorg ON aorg.id = asetting.org_unit
	INNER JOIN config.org_unit_setting_type cous ON asetting.name = cous.name
WHERE aorg.name ~* 'consortium' -- show all consortial policies
	OR aorg.name ~* 'arcanum' -- useful to capture system and branch setting, if string in name is similar.
ORDER BY aorg.name DESC, asetting.name ASC;

