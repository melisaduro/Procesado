----------------------VOZ--------------------------

declare @collectionname varchar (20) = 'torrevieja'
declare @collectionname2 varchar (20) = '%' + @collectionname + '%'


use [FY1617_Voice_Rest_3G_H1_2]

select c.sessionid, valid, invalidreason, mnc, sessiontype, collectionname
from [dbo].lcc_Serving_Cell_Table c, dbo.sessions s
where collectionname like @collectionname2
	and c.sessionid=s.sessionid
	and technology like '%LTE%' and s.valid=1
group by c.sessionid, valid, invalidreason, mnc,sessiontype, collectionname


-------------------------DATOS----------------------------

use [FY1617_Data_Rest_3G_H1_4]

select * into _temp_tech from
(select  t.testid, t.valid, t.invalidreason, mnc, testname, collectionname
from [Lcc_Data_HTTPTransfer_DL] l, testinfo t
where l.testid=t.testid and t.valid=1 and [% LTE]>0 
union
select  t.testid, t.valid, t.invalidreason, mnc, testname, collectionname
from [Lcc_Data_HTTPTransfer_UL] l, testinfo t
where l.testid=t.testid and t.valid=1 and [% LTE]>0 
union
select  t.testid, t.valid, t.invalidreason, mnc, testname, collectionname
from [Lcc_Data_HTTPBrowser] l, testinfo t
where l.testid=t.testid and t.valid=1 and [% LTE]>0 
union
select  t.testid, t.valid, t.invalidreason, mnc, testname, collectionname
from [Lcc_Data_Latencias] l, testinfo t
where l.testid=t.testid and t.valid=1 and [% LTE]>0 
union
select  t.testid, t.valid, t.invalidreason, mnc, t.testname, collectionname
from [Lcc_Data_YOUTUBE] l, testinfo t
where l.testid=t.testid and t.valid=1 and [% LTE]>0) as a

select * from _temp_tech where collectionname like @collectionname2

DROP TABLE  _temp_tech


