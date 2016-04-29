create table aaentrel as select
rel.id as relid,
ent1.name as ent1, ent1.id as entid1, 
ent2.name as ent2, ent2.id as entid2,
cat.name as reltype, rel.amount as relamt, rel.goods as goods, rel.filings as filings,
substring(rel.start_date, 1, 4) as startdate, substring(rel.end_date, 1, 4) as enddate
from relationship rel
join entity ent1
on rel.entity1_id = ent1.id 
join entity ent2
on rel.entity2_id = ent2.id 
join relationship_category cat
on rel.category_id = cat.id;


create table aaenttype as 
select ent.id as entid, ent.name as entname, extdef.id as enttypeid, extdef.display_name as enttype 
from extension_record extrec join 
entity ent on 
ent.id = extrec.entity_id join
extension_definition extdef on
extdef.id = extrec.definition_id;


create table aaentreltype as select 
ent.relid, ent.ent1, ent.entid1, type1.enttype as enttype1, ent.ent2, ent.entid2,  type2.enttype as enttype2, 
ent.reltype, ent.relamt, ent.goods, ent.filings, ent.startdate, ent.enddate
from aaentrel ent join
aaenttype type1 on
entid1 = type1.entid  join
aaenttype type2 on
entid2 = type2.entid;


create table aapolprelim as 
select elect.entity_id from elected_representative elect
UNION
select  pol.entity_id from political_candidate pol;


create table aapolperson as select
ent.name as ent, ent.id as entid, per.party_id as partyid
from entity ent join
person per on 
ent.id = per.entity_id 
where per.party_id is not null;


create table aapolitician as 
select pol.entity_id as entid, aaentrel.ent1 as name, aaentrel.entid2 as partyid,  aaentrel.ent2 as party 
from aapolprelim pol join 
aaentrel aaentrel on 
aaentrel.entid1 = pol.entity_id 
where 
(entid2 = 12886 OR
entid2 = 12901);




create table aaentrelparty as select 
ent.relid, ent.ent1, ent.entid1, type1.enttype as enttype1, pol1.partyid as entparty1, ent.ent2, ent.entid2,  type2.enttype as enttype2, pol2.partyid as entparty2,
ent.reltype, ent.relamt, ent.goods, ent.filings, ent.startdate, ent.enddate
from aaentrel ent join
aaenttype type1 on
entid1 = type1.entid  join
aaenttype type2 on
entid2 = type2.entid left outer join 
aapolperson pol1 on 
entid1 = pol1.entid  left outer join
aapolperson pol2 on 
entid2 = pol2.entid; 

create table aaparties as select id as entid, name as party from 
entity where name = 'Democratic Party' or name = 'Republican Party';


create table aaentschool as select 
ent.name as schoolname, ent.id as schoolid, sch.endowment as endow, sch.is_private as private 
from school sch join entity ent 
on sch.entity_id = ent.id;


create table aaentpers as select ent.name as name, ent.id as entid, pers.net_worth as networth 
from entity ent join person pers on pers.entity_id = ent.id;



create table aatopschools as select name, id from entity where 
id = 14730 
OR id = 14952
OR id = 14950
OR id = 14924
OR id = 14938
OR id = 15114
OR id = 14933
OR id = 15105
OR id = 14957
OR id = 15034;

create table aatopgrads as select aaentrel.ent1 as grad, aaentrel.entid1, top.name as school, top.id entid2
from aaentrel join
aatopschools top on
top.id = aaentrel.entid2;

create table aapacs as select
extrec.entity_id as entid, entity.name as name from extension_record extrec inner join entity on 
extrec.entity_id = entity.id inner join
extension_definition extdef on
(extrec.definition_id = extdef.id and
(extdef.id = 19 or
extdef.id = 11 or
extdef.id = 16 or
extdef.id = 18 or
extdef.id = 20));


create table aapoltypes as 
select id, name as type from extension_definition where 
display_name = 'Political Candidate' or
display_name = 'Elected Representative' or
display_name = 'Lobbying Firm' or
display_name = 'Political Fundraising Committee' or
display_name = 'Individual Campaign Committee' or
display_name = 'PAC' or
display_name = 'Other Campaign Committee' or
display_name = 'Political Party' or
display_name = 'Lobbyist';


create table aadonbytopgrads as 
select relid, entrel.ent1, entrel.entid1 as gradid, 
grads.school as topschool, reltype, relamt, 
ent2 as politican, entrel.entid2 as polid, party, startdate, enddate, filings  
from aaentrel entrel inner join aapolitician pol on
pol.entid = entrel.entid2 join 
aatopgrads grads on 
grads.entid1 = entrel.entid1
where (reltype = 'Donation' or reltype = 'Lobbying' ) 
and party is not null and relamt != 0;
