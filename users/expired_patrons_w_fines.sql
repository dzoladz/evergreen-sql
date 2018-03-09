-- Patrons with fines, whose records expired over 3 years ago, grouped by home library 
select
	au.id AS "Database ID",
	au.first_given_name AS "First Name",
	au.second_given_name AS "Middle Name",
	au.family_name AS "Last Name",
	au.active AS "Account Active?",
	aog.name AS "Home Library",
	to_char(au.expire_date, 'MM-DD-YYYY') AS "Date Expired", 
	sum(mmb.balance_owed) AS "Account Balance"
from money.materialized_billable_xact_summary mmb
	inner join actor.usr au ON mmb.usr = au.id 
	inner join actor.org_unit aog ON au.home_ou = aog.id 
where mmb.balance_owed > 0	
	AND au.expire_date < date_trunc('month', now()) - interval '3 years'
--	AND aog.name ~* 'marvin'
--	AND au.active = 'f'
group by au.id, aog.name
order by au.expire_date desc;