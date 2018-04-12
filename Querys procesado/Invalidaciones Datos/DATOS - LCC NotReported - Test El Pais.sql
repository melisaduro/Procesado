use FY1617_Data_Rest_4G_H2

select t.valid valid,* 
from [Lcc_Data_HTTPBrowser] b, testinfo t
where t.testid=b.testid and b.testtype ='El Pais'  and t.valid=1
	and collectionname like '%durango%'

BEGIN TRANSACTION
update testinfo
set valid=0, invalidReason='LCC NotReported'
from [Lcc_Data_HTTPBrowser] b, testinfo t
where t.testid=b.testid and b.testtype ='El Pais'  and t.valid=1
	and collectionname like '%durango%'

COMMIT