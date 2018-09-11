/* Consortium of Ohio Libraries
 * Version: Evergreen 3.1
 *
 * Description:
 * Lists Circulation Policies by Library
 * Searching by Org Unit ID is preferred
 *
 * Note: some reportable fields are not being displayed here
 */
SELECT 
	ccmm.active AS "Active?",
	ccmm.org_unit AS "Library",
	pgt.name AS "Permissions Group",
	ccmm.copy_circ_lib AS "Copy Circ Library",
	ccmm.copy_owning_lib AS "Copy Owning Library",
	ccmm.user_home_ou AS "User Home Library",
	ccmm.is_renewal AS "Is Renewal?",
	ccmm.ref_flag AS "Is Reference?",
	ccmm.juvenile_flag AS "Juvenile Flag",
	ccmm.circ_modifier AS "Circulation Modifier",
	crcd.name AS "Duration Rule",
	crmf.name AS "Max Fine Rule",
	crrf.name AS "Recurring Fine Rule",
	ccmm.usr_age_lower_bound AS "Lower Age Boundry",
	ccmm.usr_age_upper_bound AS "Upper Age Boundry",
	ccmm.circulate AS "Circulate?"
FROM config.circ_matrix_matchpoint ccmm
	INNER JOIN permission.grp_tree pgt ON pgt.id = ccmm.grp
	INNER JOIN config.rule_circ_duration crcd ON crcd.id = ccmm.duration_rule
	INNER JOIN config.rule_max_fine crmf ON crmf.id = ccmm.max_fine_rule
	INNER JOIN config.rule_recurring_fine crrf ON crrf.id = ccmm.recurring_fine_rule
WHERE org_unit = '101' -- Germantown, id is preferred here
	AND ccmm.active IS TRUE -- filter out disabled rules
	-- AND ccmm.user_home_ou = '1' -- rules applicable to the consortium
ORDER BY pgt.name, ccmm.circ_modifier
;