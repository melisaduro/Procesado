use FY1617_Data_Rest_3G_H2


-- Hay q invalidar la sesion entera, no solo los test
select distinct s.sessionid into #TTLexceeded
from testinfo t, sessions s, filelist f
where	t.sessionid=s.sessionid and s.fileid=f.fileid and t.valid=1
	and f.collectionname like '%SEVILLA%'
	and t.qualityIndication like '%ICMP TTL exceeded%'
	and s.info like '%completed%'

select * 
from testinfo t, #TTLexceeded s
where t.sessionid=s.sessionid and t.valid=1

-- Invalidacion:
BEGIN TRANSACTION
update testinfo
set valid=0, invalidReason='LCC NotReported-ICMP TTL exceeded'
from testinfo t, #TTLexceeded s
where t.sessionid=s.sessionid and t.valid=1



--------------------------------------------------------------------------
-- select * from #TTLexceeded:
--sessionid
--214
--226
--230
--1436
--2773
--2849