--use FY1617_Data_Rest_4G_H1
--SELECT t.invalidReason,T.VALID,COLLECTIONNAME, count (t.invalidReason)
--FROM TESTINFO T, SESSIONS S, FILELIST F
--WHERE collectionname like '%pajara%'
--AND F.FILEID=S.FILEID AND S.SESSIONID=T.SESSIONID
--and invalidReason
--group by t.invalidReason,T.VALID,COLLECTIONNAME

use FY1617_Voice_Smaller_4G_H1

select sessionid, invalidReason, count(collectionname) as attemps, valid, right(left(imsi,5),2) as operador
	from filelist f, sessions s
	where f.fileid=s.fileid 
	and invalidReason like 'LCC%'
	and info not like 'System Release'
	and collectionname like '%mallorca%'
group by sessionid,invalidReason, valid, imsi
order by imsi

use FY1617_Voice_Rest_4G_H1

select collectionname, invalidReason, count(collectionname) as attemps, valid, right(left(imsi,5),2) as operador
	from filelist f, sessions s
	where f.fileid=s.fileid 
	and invalidReason like 'LCC OutOfBounds%ORA'
	and info not like 'System Release'
group by collectionname, invalidReason, valid, imsi

use FY1617_DAta_Rest_3G_H1

select collectionname, t.invalidReason, count(collectionname) as attemps, t.valid, right(left(imsi,5),2) as operador
	from filelist f, sessions s, testinfo t
	where f.fileid=s.fileid and s.sessionid=t.sessionid
	and t.invalidReason like 'LCC OutOfBounds%ORA'
	and testname not like 'YouTube SD'
group by collectionname, t.invalidReason, t.valid, imsi

use FY1617_Data_Rest_4G_H1

select collectionname, t.invalidReason, count(collectionname) as attemps, t.valid, right(left(imsi,5),2) as operador
	from filelist f, sessions s, testinfo t
	where f.fileid=s.fileid and s.sessionid=t.sessionid
	and t.invalidReason like 'LCC OutOfBounds%ORA'
	and testname not like 'YouTube SD'
group by collectionname, t.invalidReason, t.valid, imsi

	use FY1617_Voice_Rest_3G_H1_2

	select collectionname, invalidReason, count(collectionname) as attemps, valid, right(left(imsi,5),2) as operador
		from filelist f, sessions s
		where f.fileid=s.fileid 
		and invalidReason like 'LCC OutOfBounds%ORA'
		and info not like 'System Release'
	group by collectionname, invalidReason, valid, imsi

use FY1617_Voice_Rest_4G_H1_2

select collectionname, invalidReason, count(collectionname) as attemps, valid, right(left(imsi,5),2) as operador
	from filelist f, sessions s
	where f.fileid=s.fileid 
	and invalidReason like 'LCC OutOfBounds%ORA'
	and info not like 'System Release'
group by collectionname, invalidReason, valid, imsi


use FY1617_DAta_Rest_3G_H1_2

select collectionname, t.invalidReason, count(collectionname) as attemps, t.valid, right(left(imsi,5),2) as operador
	from filelist f, sessions s, testinfo t
	where f.fileid=s.fileid and s.sessionid=t.sessionid
	and t.invalidReason like 'LCC OutOfBounds%ORA'
	and testname not like 'YouTube SD'
group by collectionname, t.invalidReason, t.valid, imsi

use FY1617_Data_Rest_4G_H1_2

select collectionname, t.invalidReason, count(collectionname) as attemps, t.valid, right(left(imsi,5),2) as operador
	from filelist f, sessions s, testinfo t
	where f.fileid=s.fileid and s.sessionid=t.sessionid
	and t.invalidReason like 'LCC OutOfBounds%ORA'
	and testname not like 'YouTube SD'
group by collectionname, t.invalidReason, t.valid, imsi

