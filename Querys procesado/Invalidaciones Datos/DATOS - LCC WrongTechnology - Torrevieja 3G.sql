use [FY1617_Data_Rest_3G_H1_2]

--select distinct testid from lcc_Serving_Cell_Table
--where collectionname like '%torrevieja%'
--	and technology like '%LTE%'


-------------------------------------------------------
update testinfo
set valid=0, invalidReason='LCC WrongTechnology'
--	select *  
from [Lcc_Data_HTTPTransfer_DL] l, testinfo t
where collectionname like '%torrevieja%' and l.testid=t.testid and t.valid=1
	and [% LTE]>0


update testinfo
set valid=0, invalidReason='LCC WrongTechnology'
--	select *  
from [Lcc_Data_HTTPTransfer_UL] l, testinfo t
where collectionname like '%torrevieja%' and l.testid=t.testid and t.valid=1
	and [% LTE]>0


update testinfo
set valid=0, invalidReason='LCC WrongTechnology'
--	select *  
from [dbo].[Lcc_Data_HTTPBrowser] l, testinfo t
where collectionname like '%torrevieja%' and l.testid=t.testid and t.valid=1
	and [% LTE]>0


update testinfo
set valid=0, invalidReason='LCC WrongTechnology'
--	select *  
from [Lcc_Data_Latencias] l, testinfo t
where collectionname like '%torrevieja%' and l.testid=t.testid and t.valid=1
	and [% LTE]>0


update testinfo
set valid=0, invalidReason='LCC WrongTechnology'
--	select *  
from [Lcc_Data_YOUTUBE] l, testinfo t
where collectionname like '%torrevieja%' and l.testid=t.testid and t.valid=1
	and [% LTE]>0



