use [FY1617_Data_Rest_3G_H2]

/*Ejecutamos hasta Select*/


select G.sessionid, G.testId, max(g.msgtime) as msgtime, HomeOperator, Collectionname
into #tmpsessions_with_PDP_Deactivation
from sessions s join [vGPRSInterLayerGMMSM] G on s.SessionId=G.sessionId
				join filelist f on s.FileId=f.FileId
				join networkinfo n on n.NetworkId=s.NetworkId
where s.valid=1 and (msgTypeTxt like 'Deactivate PDP context request') and direction ='U'
and sessiontype='Data'
group by G.sessionid, G.testid, HomeOperator, Collectionname


select G.sessionid, G.testId, max(g.msgtime) as msgtime, HomeOperator, Collectionname
into #tmpsessions_with_PDN_Deactivation
from sessions s join [LTENASMessages] G on s.SessionId=G.sessionId
				join filelist f on s.FileId=f.FileId
				join networkinfo n on n.NetworkId=s.NetworkId
where s.valid=1 and (MsgTypeName like 'PDN disconnect request') and direction ='U'
and sessiontype='Data'
group by G.sessionid, G.testid,HomeOperator, Collectionname

select p1.Homeoperator, p1.Collectionname, t.Sessionid,t.testid, Typeoftest,Testname, qualityIndication 
into #tmpsessions_with_PDP_Deactivation_not_to_be_invalidated
from TestInfo t	join #tmpsessions_with_PDP_Deactivation p1 on t.sessionid=p1.sessionid and t.testid=p1.testid+1 and not
(qualityindication like '%Error%' or qualityindication like '%timeout%') and typeoftest not like '%PDP%'


select p1.Homeoperator, p1.Collectionname, t.Sessionid,t.testid, Typeoftest,Testname, qualityIndication
into #tmpsessions_with_PDN_Deactivation_not_to_be_invalidated
from TestInfo t	join #tmpsessions_with_PDN_Deactivation p1 on t.sessionid=p1.sessionid and t.testid=p1.testid+1 and not
(qualityindication like '%Error%' or qualityindication like '%timeout%') and typeoftest not like '%PDP%'


select p1.Homeoperator, p1.Collectionname, t.Sessionid,t.testid, Typeoftest,Testname, qualityIndication, 'Deactivate PDP context request' as Reason, t.valid
into #tmpTest_to_be_invalidated
from TestInfo t	join #tmpsessions_with_PDP_Deactivation p1 on t.sessionid=p1.sessionid and t.starttime>p1.msgtime and
(qualityindication like '%Error%' or qualityindication like '%timeout%') and typeoftest not like '%PDP%'
where t.sessionid not in (select SessionId from #tmpsessions_with_PDP_Deactivation_not_to_be_invalidated)
union
select p2.Homeoperator, p2.Collectionname, t.Sessionid,t.testid, Typeoftest,Testname, qualityIndication, 'Deactivate PDP context request' as Reason, t.valid 
from Testinfo t	join #tmpsessions_with_PDP_Deactivation p2 on t.testid=p2.testid and 
(qualityindication like '%Error%' or qualityindication like '%timeout%') and typeoftest not like '%PDP%'
where t.sessionid not in (select sessionid from #tmpsessions_with_PDP_Deactivation_not_to_be_invalidated)
Union
select p1.Homeoperator, p1.Collectionname, t.Sessionid,t.testid, Typeoftest,Testname, qualityIndication, 'PDN disconnect request' as Reason, t.valid 
from TestInfo t	join #tmpsessions_with_PDN_Deactivation p1 on t.sessionid=p1.sessionid and t.starttime>p1.msgtime and
(qualityindication like '%Error%' or qualityindication like '%timeout%') and typeoftest not like '%PDP%'
union
select p2.Homeoperator, p2.Collectionname, t.Sessionid,t.testid, Typeoftest,Testname, qualityIndication, 'PDN disconnect request' as Reason, t.valid  
from Testinfo t	join #tmpsessions_with_PDN_Deactivation p2 on t.testid=p2.testid and 
(qualityindication like '%Error%' or qualityindication like '%timeout%') and typeoftest not like '%PDP%'


-----
/*Ejecutamos este SELECT para ver los TESTID que están implicados y nos los llevamos a la QUERY de invalidar TESTINFO*/

select * from #tmpTest_to_be_invalidated 
where valid=1
AND COLLECTIONNAME LIKE '%TUDELA%'
order by sessionid, testid

BEGIN TRANSACTION
update testinfo set valid=0, invalidReason= 'LCC NotReported' where testid in (select testid from #tmpTest_to_be_invalidated where COLLECTIONNAME LIKE '%TUDELA%') and valid=1

commit

drop table #tmpsessions_with_PDP_Deactivation,#tmpsessions_with_PDN_Deactivation, #tmpsessions_with_PDP_Deactivation_not_to_be_invalidated,#tmpsessions_with_PDN_Deactivation_not_to_be_invalidated
drop table #tmpTest_to_be_invalidated
