-- update de hassan para cambiar el nombre de los logs--

USE FY1617_Data_Rest_3G_H2

--update FileList

--set ASideFileName=replace(asidefilename,'S','X') 
begin transaction
select replace(asidefilename,'A','X')
from filelist
where collectionname like '%algeciras%'
AND ASideFileName in ('2016-12-12-18-49-52-0081-0000-0000-2158-A.mf'
,'2016-12-12-18-49-49-0079-0000-0000-2159-A.mf'
,'2016-12-12-18-49-55-0080-0000-0000-2160-A.mf'
,'2016-12-12-18-49-59-0082-0000-0000-2185-A.mf')

