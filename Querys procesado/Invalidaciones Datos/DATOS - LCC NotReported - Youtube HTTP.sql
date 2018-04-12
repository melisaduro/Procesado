use [FY1617_Data_Rest_3G_H2]

 select *  
from ResultsVideoStream r, testinfo t, sessions s, filelist f
where 
	r.testid=t.testid and t.sessionid=s.sessionid and s.fileid=f.fileid and t.valid=1
	and f.collectionname like '%VILAFRANCA%'
	and protocol='HTTP'

BEGIN TRANSACTION
update testinfo
set valid=0, invalidReason='LCC NotReported'  
from ResultsVideoStream r, testinfo t, sessions s, filelist f
where 
	r.testid=t.testid and t.sessionid=s.sessionid and s.fileid=f.fileid and t.valid=1
	and f.collectionname like '%VILAFRANCA%'
	and protocol='HTTP'

COMMIT