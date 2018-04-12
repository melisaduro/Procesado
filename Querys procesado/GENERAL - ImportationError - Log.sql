use FY1617_Voice_Rest_4G_H1_6

select *
from	filelist f, sessions s
where
	f.fileid=s.fileid
	and CollectionName like '%sueca%' and valid=1
	and asidefilename='2016-10-10-13-43-57-0044-0000-0000-1284-A.mf'

BEGIN TRANSACTION
update sessions
set valid=0. invalidReason='LCC ImportationError'
from	filelist f, sessions s
where
	f.fileid=s.fileid
	and CollectionName like '%sueca%' and valid=1
	and asidefilename='2016-10-10-13-43-57-0044-0000-0000-1284-A.mf'
