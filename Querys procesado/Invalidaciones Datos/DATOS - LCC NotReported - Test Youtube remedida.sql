use FY1617_Data_Rest_4G_H1_6


select *
from [dbo].[Lcc_Data_YOUTUBE] y, testinfo t
where
	t.testid=y.testid and t.valid=1
	and collectionname='20161102_ADD_C_CARBALLO_1_4G'

BEGIN TRANSACTION
update testinfo
set valid=0, invalidReason='LCC NotReported'
from [dbo].[Lcc_Data_YOUTUBE] y, testinfo t
where
	t.testid=y.testid and t.valid=1
	and collectionname='20161102_ADD_C_CARBALLO_1_4G'

