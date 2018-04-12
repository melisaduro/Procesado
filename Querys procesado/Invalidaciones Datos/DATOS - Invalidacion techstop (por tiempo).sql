use FY1617_Voice_Rest_3G_H1_10


select t.starttime,*
	from filelist f, sessions s, testinfo t
	where	
		f.fileid=s.fileid and s.sessionid=t.sessionid
		and f. collectionname like '%yecla%'
		and starttime between '2016-11-16 17:51:07.104' and '2016-11-16 17:54:27.569'

BEGIN TRANSACTION
update testinfo
set valid=0, invalidReason='LCC TechStop'
from filelist f, sessions s, testinfo t
where	
		f.fileid=s.fileid and s.sessionid=t.sessionid
		and f. collectionname like '%yecla%'
		and starttime between '2016-11-16 17:51:07.104' and '2016-11-16 17:54:27.569'
