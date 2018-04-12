-- Cambiamos el nombre de los logs

USE FY1617_Voice_Rest_3G_H2

select valid,*
from filelist f, sessions s
where collectionname like '20161212%algeciras%'
and f.fileid=s.fileid
and valid=1

begin transaction
update sessions
set valid=0, invalidReason='LCC ImportationError'
from filelist f, sessions s
where collectionname like '20161212%algeciras%'
and f.fileid=s.fileid
and valid=1

commit

--Renombramos logs tanto de la parte A como de la parte B

select replace(asidefilename,'A','X')
from filelist
where ASideFileName in ('2016-12-12-18-49-52-0081-0000-0000-2158-A.mf'
,'2016-12-12-18-49-49-0079-0000-0000-2159-A.mf'
,'2016-12-12-18-49-55-0080-0000-0000-2160-A.mf'
,'2016-12-12-18-49-59-0082-0000-0000-2185-A.mf')
and collectionname like '%algeciras%'

begin transaction
update fileList
set ASideFileName=replace(asidefilename,'A','X') 
from filelist
where ASideFileName in ('2016-12-12-18-49-52-0081-0000-0000-2158-A.mf'
,'2016-12-12-18-49-49-0079-0000-0000-2159-A.mf'
,'2016-12-12-18-49-55-0080-0000-0000-2160-A.mf'
,'2016-12-12-18-49-59-0082-0000-0000-2185-A.mf')
and collectionname like '%algeciras%'

commit

select replace(Bsidefilename,'B','Y')
from filelist
where BSideFileName in ('2016-12-12-18-49-52-0081-0000-0000-2158-B.mf'
,'2016-12-12-18-49-49-0079-0000-0000-2159-B.mf'
,'2016-12-12-18-49-55-0080-0000-0000-2160-B.mf'
,'2016-12-12-18-49-59-0082-0000-0000-2185-B.mf')
and collectionname like '%algeciras%'

begin transaction
update fileList
set BSideFileName=replace(Bsidefilename,'B','Y')
from filelist
where BSideFileName in ('2016-12-12-18-49-52-0081-0000-0000-2158-B.mf'
,'2016-12-12-18-49-49-0079-0000-0000-2159-B.mf'
,'2016-12-12-18-49-55-0080-0000-0000-2160-B.mf'
,'2016-12-12-18-49-59-0082-0000-0000-2185-B.mf')
and collectionname like '%algeciras%'

commit