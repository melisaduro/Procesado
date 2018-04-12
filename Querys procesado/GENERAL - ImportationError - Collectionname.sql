--use FY1617_Voice_Rest_3G_H1_7 

--BEGIN TRANSACTION
--update sessions
--set valid=0, invalidReason='LCC ImportationError'
----select valid,*
--from filelist f, sessions s
--where 
--f.fileid=s.fileid
--and collectionname like '%20161024%molins%'

--ROLLBACK

use FY1617_Data_Rest_4G_H1_6

select t.valid,*
from filelist f, sessions s, testinfo t
where 
f.fileid=s.fileid and t.sessionid=s.sessionid and t.valid=1
and f.collectionname like '20161024%ARGANDA%'

BEGIN TRANSACTION
update testinfo
set valid=0, invalidReason='LCC ImportationError'
from filelist f, sessions s, testinfo t
where 
f.fileid=s.fileid and t.sessionid=s.sessionid and t.valid=1
and f.collectionname like '20161024%ARGANDA%'

commit

