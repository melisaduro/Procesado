IF object_ID(N'[dbo].[sp_MDD_Voice_Libro_Voz_TLT_All]') IS NOT NULL
              DROP PROCEDURE [dbo ].[sp_MDD_Voice_Libro_Voz_TLT_All]
GO
CREATE PROCEDURE [dbo].[sp_MDD_Voice_Libro_Voz_TLT_All] (
	 --Variables de entrada
				@mob1 as varchar(256),
				@mob2 as varchar(256),
				@mob3 as varchar(256),
				@ciudad as varchar(256),
				@simOperator as int,
				@fecha_ini_text1 as varchar(256),
				@fecha_fin_text1 as varchar (256),
				@fecha_ini_text2 as varchar(256),
				@fecha_fin_text2 as varchar (256),
				@fecha_ini_text3 as varchar(256),
				@fecha_fin_text3 as varchar (256),
				@fecha_ini_text4 as varchar(256),
				@fecha_fin_text4 as varchar (256),
				@fecha_ini_text5 as varchar(256),
				@fecha_fin_text5 as varchar (256),
				@fecha_ini_text6 as varchar(256),
				@fecha_fin_text6 as varchar (256),
				@fecha_ini_text7 as varchar(256),
				@fecha_fin_text7 as varchar (256),
				@fecha_ini_text8 as varchar(256),
				@fecha_fin_text8 as varchar (256),
				@fecha_ini_text9 as varchar(256),
				@fecha_fin_text9 as varchar (256),
				@fecha_ini_text10 as varchar(256),
				@fecha_fin_text10 as varchar (256),
				@type as varchar (256),
				@Date as varchar (256),
				@TechF as varchar (256),
				@Environ as varchar (256),
				@LTE as int
				)
AS

-----------------------------
----- Testing Variables -----
-----------------------------
--declare @mob1 as varchar(256) = '354720054741835'
--declare @mob2 as varchar(256) = '354720054742668'
--declare @mob3 as varchar(256) = 'Ninguna'

--declare @fecha_ini_text1 as varchar (256) = '2015-04-20 09:00:00.000'
--declare @fecha_fin_text1 as varchar (256) = '2015-04-22 15:00:00.000'
--declare @fecha_ini_text2 as varchar (256) = '2015-01-13 20:11:00.000'
--declare @fecha_fin_text2 as varchar (256) = '2015-01-13 20:11:00.000'
--declare @fecha_ini_text3 as varchar (256) = '2014-08-20 13:33:00.000'
--declare @fecha_fin_text3 as varchar (256) = '2014-08-20 13:33:00.000'
--declare @fecha_ini_text4 as varchar (256) = '2014-06-23 18:30:00.000'
--declare @fecha_fin_text4 as varchar (256) = '2014-06-23 18:30:00.000'
--declare @fecha_ini_text5 as varchar (256) = '2014-06-23 18:30:00.000'
--declare @fecha_fin_text5 as varchar (256) = '2014-06-23 18:30:00.000'
--declare @fecha_ini_text6 as varchar (256) = '2014-06-23 18:30:00.000'
--declare @fecha_fin_text6 as varchar (256) = '2014-06-23 18:30:00.000'
--declare @fecha_ini_text7 as varchar (256) = '2014-08-07 10:40:00.000'
--declare @fecha_fin_text7 as varchar (256) = '2014-08-07 10:40:00.000'
--declare @fecha_ini_text8 as varchar (256) = '2014-08-12 09:40:00.000'
--declare @fecha_fin_text8 as varchar (256) = '2014-08-12 09:40:00.000'
--declare @fecha_ini_text9 as varchar (256) = '2014-08-12 09:40:00.000'
--declare @fecha_fin_text9 as varchar (256) = '2014-08-12 09:40:00.000'
--declare @fecha_ini_text10 as varchar (256) = '2014-08-12 09:40:00.000'
--declare @fecha_fin_text10 as varchar (256) = '2014-08-12 09:40:00.000'


--declare @ciudad as varchar(256) = 'ZARAUTZ'
--declare @simOperator as int = 1
--declare @type as varchar(256) = 'M2M'
--declare @Date as varchar (256) = ''
--declare @TechF as varchar (256)='4G'
--declare @Environ as varchar (256)='%%'
--declare @LTE as int=0



-----------------------------
----- Date Declarations -----
-----------------------------	
declare @fecha_ini1 as datetime = @fecha_ini_text1
declare @fecha_fin1 as datetime = @fecha_fin_text1
declare @fecha_ini2 as datetime = @fecha_ini_text2
declare @fecha_fin2 as datetime = @fecha_fin_text2
declare @fecha_ini3 as datetime = @fecha_ini_text3
declare @fecha_fin3 as datetime = @fecha_fin_text3
declare @fecha_ini4 as datetime = @fecha_ini_text4
declare @fecha_fin4 as datetime = @fecha_fin_text4
declare @fecha_ini5 as datetime = @fecha_ini_text5
declare @fecha_fin5 as datetime = @fecha_fin_text5
declare @fecha_ini6 as datetime = @fecha_ini_text6
declare @fecha_fin6 as datetime = @fecha_fin_text6
declare @fecha_ini7 as datetime = @fecha_ini_text7
declare @fecha_fin7 as datetime = @fecha_fin_text7
declare @fecha_ini8 as datetime = @fecha_ini_text8
declare @fecha_fin8 as datetime = @fecha_fin_text8
declare @fecha_ini9 as datetime = @fecha_ini_text9
declare @fecha_fin9 as datetime = @fecha_fin_text9
declare @fecha_ini10 as datetime = @fecha_ini_text10
declare @fecha_fin10 as datetime = @fecha_fin_text10

-------------------------------------------------------------------------------
-- GLOBAL FILTER:
-------------------------------------------------------------------------------		  
select v.sessionid

into #All_Tests
from lcc_Calls_Detailed v, sessions s
Where s.sessionid=v.sessionid
	and s.valid=1
	and v.collectionname like @Date + '%' + @ciudad + '%' + @TechF
	and v.MNC = @simOperator	--MNC
	and v.MCC= 214						--MCC - Descartamos los valores erróneos	
	and v.calltype = @type
	--and (v.callStartTimeStamp between @fecha_ini1 and @fecha_fin1 
	--		 or
	--		 v.callStartTimeStamp between @fecha_ini2 and @fecha_fin2 
	--		 or
	--		 v.callStartTimeStamp between @fecha_ini3 and @fecha_fin3 
	--		 or
	--		 v.callStartTimeStamp between @fecha_ini4 and @fecha_fin4 
	--		 or
	--		 v.callStartTimeStamp between @fecha_ini5 and @fecha_fin5 
	--		 or
	--		 v.callStartTimeStamp between @fecha_ini6 and @fecha_fin6
 --			 or
	--		 v.callStartTimeStamp between @fecha_ini7 and @fecha_fin7 
 --			 or
	--		 v.callStartTimeStamp between @fecha_ini8 and @fecha_fin8 
 --			 or
	--		 v.callStartTimeStamp between @fecha_ini9 and @fecha_fin9 
 --			 or
	--		 v.callStartTimeStamp between @fecha_ini10 and @fecha_fin10 			 
	--		 or
	--		 v.callEndTimeStamp between @fecha_ini1 and @fecha_fin1 
	--		 or
	--		 v.callEndTimeStamp between @fecha_ini2 and @fecha_fin2 
	--		 or
	--		 v.callEndTimeStamp between @fecha_ini3 and @fecha_fin3 
	--		 or
	--		 v.callEndTimeStamp between @fecha_ini4 and @fecha_fin4 
	--		 or
	--		 v.callEndTimeStamp between @fecha_ini5 and @fecha_fin5 
	--		 or
	--		 v.callEndTimeStamp between @fecha_ini6 and @fecha_fin6
 --			 or
	--		 v.callEndTimeStamp between @fecha_ini7 and @fecha_fin7 
 --			 or
	--		 v.callEndTimeStamp between @fecha_ini8 and @fecha_fin8 
 --			 or
	--		 v.callEndTimeStamp between @fecha_ini9 and @fecha_fin9 
 --			 or
	--		 v.callEndTimeStamp between @fecha_ini10 and @fecha_fin10 			 
	--     )

------------------------- CST 95th Percentile---------------------------------

--------------------------- CST Main Table -----------------------------------

declare @CSTresult float

if @type = 'M2M' --Sólo las muestras con GPS
	begin

	create table #CST_perc ([value] float null)		
	create table #MO_CST_A ([CST_A_95] float null)
	create table #MO_CST_C ([CST_C_95] float null)
	create table #MT_CST_A ([CST_A_95] float null)
	create table #MT_CST_C ([CST_C_95] float null)
	create table #MOMT_CST_A ([CST_A_95] float null)
	create table #MOMT_CST_C ([CST_C_95] float null)

		select v.Sessionid, callDir ,cst_till_alerting, cst_till_connAck

		into #CST_MAIN
		from #All_Tests a,
			 lcc_Calls_Detailed v,
			 agrids.dbo.lcc_parcelas lp

		where a.Sessionid=v.Sessionid
		and callDir in ('MO', 'MT')
		and callstatus = 'Completed'
		and (cst_till_alerting is not null or cst_till_connAck is not null)
		and lp.Nombre= master.dbo.fn_lcc_getParcel(v.longitude_fin_A, v.latitude_fin_A)
		and lp.entorno like @Environ

		---- MO CST Percentile
		insert into #CST_perc
		select  cst_till_alerting/1000.0 as cst_till_alerting
				
				from #CST_Main
				where callDir= 'MO'
				and cst_till_alerting is not null

		exec sp_lcc_Percentil 95, 0.5, '#CST_perc', @CSTresult output

		insert into #MO_CST_A
		select @CSTresult

		set @CSTresult= null
		
		delete from #CST_perc


		insert into #CST_perc
		select  cst_till_connack/1000.0 as  cst_till_connAck
				from #CST_Main
				where callDir= 'MO'
				and cst_till_connack is not null

		exec sp_lcc_Percentil 95, 0.5, '#CST_perc', @CSTresult output

		insert into #MO_CST_C 
		select @CSTresult

		set @CSTresult= null

		delete from #CST_perc

		---- MT CST Percentile
		insert into #CST_perc
		select  cst_till_alerting/1000.0 as cst_till_alerting
				from #CST_Main
				where callDir= 'MT'
				and cst_till_alerting is not null
		
		exec sp_lcc_Percentil 95, 0.5, '#CST_perc', @CSTresult output

		insert into #MT_CST_A
		select @CSTresult

		set @CSTresult= null

		delete from #CST_perc

		insert into #CST_perc
		select  cst_till_connack/1000.0 as  cst_till_connAck
				from #CST_Main
				where callDir= 'MT'
				and cst_till_connack is not null

		exec sp_lcc_Percentil 95, 0.5, '#CST_perc', @CSTresult output
		
		insert into #MT_CST_C
		select @CSTresult

		set @CSTresult= null

		delete from #CST_perc

		---- MO+MT CST Percentile
		insert into #CST_perc
		select  cst_till_alerting/1000.0 as cst_till_alerting
				from #CST_Main
				where cst_till_alerting is not null
				
		exec sp_lcc_Percentil 95, 0.5, '#CST_perc', @CSTresult output

		insert into #MOMT_CST_A
		select @CSTresult

		set @CSTresult= null
		
		delete from #CST_perc
		
		insert into #CST_perc
		select  cst_till_connAck/1000.0 as  cst_till_connAck
				from #CST_Main
				where cst_till_connack is not null
		
		exec sp_lcc_Percentil 95, 0.5, '#CST_perc', @CSTresult output

		insert into #MOMT_CST_C
		select @CSTresult

		set @CSTresult= null

		delete from #CST_perc

	--	select v.Sessionid, callDir ,cst_till_alerting, cst_till_connAck,
	--	ROW_NUMBER() over (partition by v.calldir order by v.cst_till_alerting, v.calldir) as id_A,
	--	ROW_NUMBER() over (partition by v.calldir order by v.cst_till_connAck, v.calldir) as id_C,
	--	ROW_NUMBER() over (order by v.cst_till_alerting, v.calldir) as id_all_A,
	--	ROW_NUMBER() over (order by v.cst_till_connAck, v.calldir) as id_all_C


	--	into #CST_MAIN
	--	from #All_Tests a,
	--		 lcc_Calls_Detailed v,
	--		 agrids.dbo.lcc_parcelas lp

	--	where a.Sessionid=v.Sessionid
	--	and callDir in ('MO', 'MT')
	--	and callstatus='Completed'
	--	and (cst_till_alerting is not null or cst_till_connAck is not null)
	--	and lp.Nombre= master.dbo.fn_lcc_getParcel(v.longitude_fin_A, v.latitude_fin_A)
	--	and lp.entorno like @Environ

	---- MO CST Percentile

	---- 'Til Alerting
	--	select  cs.cst_till_alerting/1000.0 as CST_A_95

	--	into #MO_CST_A
	--	from #CST_MAIN cs,
	--		 (Select round(MAX(id_A)*0.95,0) as id
	--			from #CST_MAIN
	--			where callDir= 'MO') csmo	
	--	where
	--	(cs.id_A=csmo.id and cs.callDir = 'MO')

	--	-- 'Til Connect
	--	select  cs.cst_till_connAck/1000.0 as CST_C_95

	--	into #MO_CST_C
	--	from #CST_MAIN cs,
	--		 (Select round(MAX(id_C)*0.95,0) as id
	--			from #CST_MAIN
	--			where callDir= 'MO') csmo	
	--	where
	--	(cs.id_C=csmo.id and cs.callDir = 'MO')

	--	-- MT CST Percentile

	--	-- 'Til Alerting
	--	select  cs.cst_till_alerting/1000.0 as CST_A_95

	--	into #MT_CST_A
	--	from #CST_MAIN cs,
	--		 (Select round(MAX(id_A)*0.95,0) as id
	--			from #CST_MAIN
	--			where callDir= 'MT') csmt	
	--	where
	--	(cs.id_A=csmt.id and cs.callDir = 'MT')

	--	-- 'Til Connect
	--	select  cs.cst_till_connAck/1000.0 as CST_C_95

	--	into #MT_CST_C
	--	from #CST_MAIN cs,
	--		 (Select round(MAX(id_C)*0.95,0) as id
	--			from #CST_MAIN
	--			where callDir= 'MT') csmt	
	--	where
	--	(cs.id_C=csmt.id and cs.callDir = 'MT')

	--	-- MO+MT CST Percentile

	--	-- 'Til Alerting
	--	select  cs.cst_till_alerting/1000.0 as CST_A_95

	--	into #MOMT_CST_A
	--	from #CST_MAIN cs,
	--		(Select round(MAX(id_All_A)*0.95,0) as id_all
	--			from #CST_MAIN) csma 
	--	where
	--	(cs.id_all_A=csma.id_all)


	--	-- 'Til Connect
	--	select  cs.cst_till_connAck/1000.0 as CST_C_95

	--	into #MOMT_CST_C
	--	from #CST_MAIN cs,
	--		(Select round(MAX(id_All_C)*0.95,0) as id_all
	--			from #CST_MAIN) csma 
	--	where
	--	(cs.id_all_C=csma.id_all)
	
	end



else

	begin

	create table #CST_perc_Indoor ([value] float null)		
	create table #MO_CST_A_Indoor ([CST_A_95] float null)
	create table #MO_CST_C_Indoor ([CST_C_95] float null)
	create table #MT_CST_A_Indoor ([CST_A_95] float null)
	create table #MT_CST_C_Indoor ([CST_C_95] float null)
	create table #MOMT_CST_A_Indoor ([CST_A_95] float null)
	create table #MOMT_CST_C_Indoor ([CST_C_95] float null)

		select v.Sessionid, callDir ,cst_till_alerting, cst_till_connAck

		into #CST_MAIN_Indoor
		from #All_Tests a,
			 lcc_Calls_Detailed v

		where a.Sessionid=v.Sessionid
		and callDir in ('MO', 'MT')
		and callstatus = 'Completed'
		and (cst_till_alerting is not null or cst_till_connAck is not null)

		---- MO CST Percentile
		insert into #CST_perc_Indoor
		select  cst_till_alerting/1000.0 as cst_till_alerting
				
				from #CST_Main_Indoor
				where callDir= 'MO'
				and cst_till_alerting is not null

		exec sp_lcc_Percentil 95, 0.5, '#CST_perc_Indoor', @CSTresult output

		insert into #MO_CST_A_Indoor
		select @CSTresult

		set @CSTresult= null
		
		delete from #CST_perc_Indoor


		insert into #CST_perc_Indoor
		select  cst_till_connack/1000.0 as  cst_till_connAck
				from #CST_Main_Indoor
				where callDir= 'MO'
				and cst_till_connack is not null

		exec sp_lcc_Percentil 95, 0.5, '#CST_perc_Indoor', @CSTresult output

		insert into #MO_CST_C_Indoor
		select @CSTresult

		set @CSTresult= null

		delete from #CST_perc_Indoor

		---- MT CST Percentile
		insert into #CST_perc_Indoor
		select  cst_till_alerting/1000.0 as cst_till_alerting
				from #CST_Main_Indoor
				where callDir= 'MT'
				and cst_till_alerting is not null
		
		exec sp_lcc_Percentil 95, 0.5, '#CST_perc_Indoor', @CSTresult output

		insert into #MT_CST_A_Indoor
		select @CSTresult

		set @CSTresult= null

		delete from #CST_perc_Indoor

		insert into #CST_perc_Indoor
		select  cst_till_connack/1000.0 as  cst_till_connAck
				from #CST_Main_Indoor
				where callDir= 'MT'
				and cst_till_connack is not null

		exec sp_lcc_Percentil 95, 0.5, '#CST_perc_Indoor', @CSTresult output
		
		insert into #MT_CST_C_Indoor
		select @CSTresult

		set @CSTresult= null

		delete from #CST_perc_Indoor

		---- MO+MT CST Percentile
		insert into #CST_perc_Indoor
		select  cst_till_alerting/1000.0 as cst_till_alerting
				from #CST_Main_Indoor
				where cst_till_alerting is not null
				
		exec sp_lcc_Percentil 95, 0.5, '#CST_perc_Indoor', @CSTresult output

		insert into #MOMT_CST_A_Indoor
		select @CSTresult

		set @CSTresult= null
		
		delete from #CST_perc_Indoor
		
		insert into #CST_perc_Indoor
		select  cst_till_connAck/1000.0 as  cst_till_connAck
				from #CST_Main_Indoor
				where cst_till_connack is not null
		
		exec sp_lcc_Percentil 95, 0.5, '#CST_perc_Indoor', @CSTresult output

		insert into #MOMT_CST_C_Indoor
		select @CSTresult

		set @CSTresult= null

		delete from #CST_perc_Indoor

	--	select v.Sessionid, callDir ,cst_till_alerting, cst_till_connAck,
	--	ROW_NUMBER() over (partition by v.calldir order by v.cst_till_alerting, v.calldir) as id_A,
	--	ROW_NUMBER() over (partition by v.calldir order by v.cst_till_connAck, v.calldir) as id_C,
	--	ROW_NUMBER() over (order by v.cst_till_alerting, v.calldir) as id_all_A,
	--	ROW_NUMBER() over (order by v.cst_till_connAck, v.calldir) as id_all_C


	--	into #CST_MAIN_Indoor
	--	from #All_Tests a,
	--		 lcc_Calls_Detailed v

	--	where a.Sessionid=v.Sessionid
	--	and callDir in ('MO', 'MT')
	--	and callstatus='Completed'
	--	and (cst_till_alerting is not null or cst_till_connAck is not null)

	
	---- MO CST Percentile

	---- 'Til Alerting
	--	select  cs.cst_till_alerting/1000.0 as CST_A_95

	--	into #MO_CST_A_Indoor
	--	from #CST_MAIN_Indoor cs,
	--		 (Select round(MAX(id_A)*0.95,0) as id
	--			from #CST_MAIN_Indoor
	--			where callDir= 'MO') csmo	
	--	where
	--	(cs.id_A=csmo.id and cs.callDir = 'MO')

	--	-- 'Til Connect
	--	select  cs.cst_till_connAck/1000.0 as CST_C_95

	--	into #MO_CST_C_Indoor
	--	from #CST_MAIN_Indoor cs,
	--		 (Select round(MAX(id_C)*0.95,0) as id
	--			from #CST_MAIN_Indoor
	--			where callDir= 'MO') csmo	
	--	where
	--	(cs.id_C=csmo.id and cs.callDir = 'MO')

	--	-- MT CST Percentile

	--	-- 'Til Alerting
	--	select  cs.cst_till_alerting/1000.0 as CST_A_95

	--	into #MT_CST_A_Indoor
	--	from #CST_MAIN_Indoor cs,
	--		 (Select round(MAX(id_A)*0.95,0) as id
	--			from #CST_MAIN_Indoor
	--			where callDir= 'MT') csmt	
	--	where
	--	(cs.id_A=csmt.id and cs.callDir = 'MT')

	--	-- 'Til Connect
	--	select  cs.cst_till_connAck/1000.0 as CST_C_95

	--	into #MT_CST_C_Indoor
	--	from #CST_MAIN_Indoor cs,
	--		 (Select round(MAX(id_C)*0.95,0) as id
	--			from #CST_MAIN_Indoor
	--			where callDir= 'MT') csmt	
	--	where
	--	(cs.id_C=csmt.id and cs.callDir = 'MT')

	--	-- MO+MT CST Percentile

	--	-- 'Til Alerting
	--	select  cs.cst_till_alerting/1000.0 as CST_A_95

	--	into #MOMT_CST_A_Indoor
	--	from #CST_MAIN_Indoor cs,
	--		(Select round(MAX(id_All_A)*0.95,0) as id_all
	--			from #CST_MAIN_Indoor) csma 
	--	where
	--	(cs.id_all_A=csma.id_all)


	--	-- 'Til Connect
	--	select  cs.cst_till_connAck/1000.0 as CST_C_95

	--	into #MOMT_CST_C_Indoor
	--	from #CST_MAIN_Indoor cs,
	--		(Select round(MAX(id_All_C)*0.95,0) as id_all
	--			from #CST_MAIN_Indoor) csma 
	--	where
	--	(cs.id_all_C=csma.id_all)

end

------------------------- CST 95th Percentile---------------------------------

--------------------------- MOS Percentile -----------------------------------

--------------------------- MOS Main Table -----------------------------------

declare @MOSresult float

if @type = 'M2M' --Sólo las muestras con GPS
	begin
		
	create table #MOS_perc ([value] float null)		
	create table #MOS_NB_5TH ([MOS_5] float null)
	create table #MOS_WB_MED ([MOS_MED] float null)
	create table #MOS_ALL_5TH ([MOS_5] float null)
	create table #MOS_ALL_STDEV ([MOS] float null)

		-- MOS disaggregated Main Table

		Select  m.sessionid, m.testid,
		(case when m.OptionalWB is not null then m.OptionalWB else m.OptionalNB end) as MOS,
		(case when m.BandWidth=0 then 'NB' else 'WB' end) as MOS_Type,
		case t.direction
			 when 'A->B' then 'U'
			 when 'B->A' then 'D'
			 Else t.direction
		end as MOS_Test_Direction

		into #MOS_MAIN

		from dbo.ResultsLQ08Avg m, TestInfo t, #All_Tests a, lcc_calls_detailed v,
			 agrids.dbo.lcc_parcelas lp
		
		where m.TestId=t.TestId
		and a.Sessionid=m.SessionId and t.SessionId=a.Sessionid
		and a.sessionid=v.sessionid
		and (m.OptionalNB is not null or m.OptionalWB is not null)
		and Appl in (10, 110, 1010, 20, 120, 12, 1012, 22) -- Application Codes for POLQA NB and WB Codecs
		and v.callStatus = 'Completed'
		and lp.Nombre= master.dbo.fn_lcc_getParcel(v.longitude_fin_A, v.latitude_fin_A)
		and lp.entorno like @Environ

		-- MOS NB 5th Percentile
		insert into #MOS_perc
		select  MOS as  MOS_5
				from #MOS_MAIN
				where MOS_Type='NB'
				and MOS is not null
				
		exec sp_lcc_Percentil 5, 0.5, '#MOS_perc', @MOSresult output

		insert into #MOS_NB_5TH
		select @MOSresult

		set @MOSresult= null
		
		delete from #MOS_perc

		---- MOS WB Median

		insert into #MOS_perc
		select  MOS as  MOS_MED
				from #MOS_MAIN
				where MOS_Type='WB'
				and MOS is not null

		exec sp_lcc_Percentil 50, 0.5, '#MOS_perc', @MOSresult output
		
		insert into #MOS_WB_MED
		select @MOSresult
		
		set @MOSresult= null

		delete from #MOS_perc

		-- MOS ALL 5th Percentile

		insert into #MOS_perc
		select  MOS as  MOS_5
				from #MOS_MAIN
				where MOS is not null
				
		exec sp_lcc_Percentil 5, 0.5, '#MOS_perc', @MOSresult output

		insert into #MOS_ALL_5TH
		select @MOSresult
		
		set @MOSresult= null

		delete from #MOS_perc

		-- MOS ALL STDEVP

		insert into #MOS_perc
		select  MOS
				from #MOS_MAIN
				where MOS is not null
				
		exec sp_lcc_STDEVP 0.5, '#MOS_perc', @MOSresult output

		insert into #MOS_ALL_STDEV
		select @MOSresult
		
		set @MOSresult= null

		delete from #MOS_perc


		---- MOS disaggregated Main Table

		--Select  m.sessionid, m.testid,
		--(case when m.OptionalNB is not null then m.OptionalNB else m.OptionalWB end) as MOS,
		--(case when m.BandWidth=0 then 'NB' else 'WB' end) as MOS_Type,
		--case t.direction
		--	 when 'A->B' then 'U'
		--	 when 'B->A' then 'D'
		--	 Else t.direction
		--end as MOS_Test_Direction,
		--ROW_NUMBER() over (order by (case when m.OptionalNB is not null then m.OptionalNB else m.OptionalWB end) asc) as idAll,
		--ROW_NUMBER() over (partition by (case when m.BandWidth=0 then 'NB' else 'WB' end) 
		--				   order by (case when m.BandWidth=0 then 'NB' else 'WB' end),
		--				  (case when m.OptionalNB is not null then m.OptionalNB else m.OptionalWB end) asc) as id

		--into #MOS_MAIN

		--from dbo.ResultsLQ08Avg m, TestInfo t, #All_Tests a, lcc_calls_detailed v,
		--	 agrids.dbo.lcc_parcelas lp
		
		--where m.TestId=t.TestId
		--and a.Sessionid=m.SessionId and t.SessionId=a.Sessionid
		--and a.sessionid=v.sessionid
		--and (m.OptionalNB is not null or m.OptionalWB is not null)
		--and Appl in (10, 110, 1010, 20, 120, 12, 1012, 22) -- Application Codes for POLQA NB and WB Codecs
		--and lp.Nombre= master.dbo.fn_lcc_getParcel(v.longitude_fin_A, v.latitude_fin_A)
		--and lp.entorno like @Environ

		---- MOS NB 5th Percentile

		--select MOS as MOS_5

		--into #MOS_NB_5TH
		--from #MOS_MAIN ms,
		--	(Select round(MAX(id)*0.05,0) as id
		--		from #MOS_MAIN
		--		where MOS_Type='NB') msma 
		--where
		--(ms.id=msma.id)
		--and ms.MOS_Type='NB'
		---- MOS WB Median

		--select MOS as MOS_MED

		--into #MOS_WB_MED
		--from #MOS_MAIN ms,
		--	(Select round(MAX(id)*0.5,0) as id
		--		from #MOS_MAIN
		--		where MOS_Type='WB') msma 
		--where
		--(ms.id=msma.id)
		--and ms.MOS_Type='WB'

		---- MOS ALL 5th Percentile

		--select MOS as MOS_5

		--into #MOS_ALL_5TH
		--from #MOS_MAIN ms,
		--	(Select round(MAX(idAll)*0.05,0) as id
		--		from #MOS_MAIN) msma 
		--where
		--(ms.idALL=msma.id)
	end
else

begin
		
	create table #MOS_perc_Indoor ([value] float null)		
	create table #MOS_NB_5TH_Indoor ([MOS_5] float null)
	create table #MOS_WB_MED_Indoor ([MOS_MED] float null)
	create table #MOS_ALL_5TH_Indoor ([MOS_5] float null)
	create table #MOS_NB_STDEV_Indoor ([MOS] float null)

		-- MOS disaggregated Main Table

		Select  m.sessionid, m.testid,
		(case when m.OptionalWB is not null then m.OptionalWB else m.OptionalNB end) as MOS,
		(case when m.BandWidth=0 then 'NB' else 'WB' end) as MOS_Type,
		case t.direction
			 when 'A->B' then 'U'
			 when 'B->A' then 'D'
			 Else t.direction
		end as MOS_Test_Direction

		into #MOS_MAIN_Indoor

		from dbo.ResultsLQ08Avg m, TestInfo t, #All_Tests a, lcc_calls_detailed v
		where m.TestId=t.TestId
		and a.Sessionid=m.SessionId and t.SessionId=a.Sessionid
		and a.sessionid=v.sessionid
		and (m.OptionalNB is not null or m.OptionalWB is not null)
		and Appl in (10, 110, 1010, 20, 120, 12, 1012, 22) -- Application Codes for POLQA NB and WB Codecs
		and v.callStatus = 'Completed'

		-- MOS NB 5th Percentile
		insert into #MOS_perc_Indoor
		select  MOS as  MOS_5
				from #MOS_MAIN_Indoor
				where MOS_Type='NB'
				and MOS is not null
				
		exec sp_lcc_Percentil 5, 0.5, '#MOS_perc_Indoor', @MOSresult output

		insert into #MOS_NB_5TH_Indoor
		select @MOSresult

		set @MOSresult= null
		
		delete from #MOS_perc_Indoor

		---- MOS WB Median

		insert into #MOS_perc_Indoor
		select  MOS as  MOS_MED
				from #MOS_MAIN_Indoor
				where MOS_Type='WB'
				and MOS is not null

		exec sp_lcc_Percentil 50, 0.5, '#MOS_perc_Indoor', @MOSresult output
		
		insert into #MOS_WB_MED_Indoor
		select @MOSresult
		
		set @MOSresult= null

		delete from #MOS_perc_Indoor

		-- MOS ALL 5th Percentile

		insert into #MOS_perc_Indoor
		select  MOS as  MOS_5
				from #MOS_MAIN_Indoor
				where MOS is not null
				
		exec sp_lcc_Percentil 5, 0.5, '#MOS_perc_Indoor', @MOSresult output

		insert into #MOS_ALL_5TH_Indoor
		select @MOSresult
		
		set @MOSresult= null

		delete from #MOS_perc_Indoor

		-- MOS NB STDEV

		insert into #MOS_perc_Indoor
		select  MOS
				from #MOS_MAIN_Indoor
				where MOS_Type='NB'
				and MOS is not null
				
		exec sp_lcc_STDEVP 0.5, '#MOS_perc_Indoor', @MOSresult output

		insert into #MOS_NB_STDEV_Indoor
		select @MOSresult
		
		set @MOSresult= null

		delete from #MOS_perc_Indoor
		

		---- MOS disaggregated Main Table

		--Select  m.sessionid, m.testid,
		--(case when m.OptionalNB is not null then m.OptionalNB else m.OptionalWB end) as MOS,
		--(case when m.BandWidth=0 then 'NB' else 'WB' end) as MOS_Type,
		--case t.direction
		--	 when 'A->B' then 'U'
		--	 when 'B->A' then 'D'
		--	 Else t.direction
		--end as MOS_Test_Direction,
		--ROW_NUMBER() over (order by (case when m.OptionalNB is not null then m.OptionalNB else m.OptionalWB end) asc) as idAll,
		--ROW_NUMBER() over (partition by (case when m.BandWidth=0 then 'NB' else 'WB' end) 
		--				   order by (case when m.BandWidth=0 then 'NB' else 'WB' end),
		--				  (case when m.OptionalNB is not null then m.OptionalNB else m.OptionalWB end) asc) as id

		--into #MOS_MAIN_Indoor

		--from dbo.ResultsLQ08Avg m, TestInfo t, #All_Tests a
		--where m.TestId=t.TestId
		--and a.Sessionid=m.SessionId and t.SessionId=a.Sessionid
		--and (m.OptionalNB is not null or m.OptionalWB is not null)
		--and Appl in (10, 110, 1010, 20, 120, 12, 1012, 22) -- Application Codes for POLQA NB and WB Codecs

		---- MOS NB 5th Percentile

		--select MOS as MOS_5

		--into #MOS_NB_5TH_Indoor
		--from #MOS_MAIN_Indoor ms,
		--	(Select round(MAX(id)*0.05,0) as id
		--		from #MOS_MAIN_Indoor
		--		where MOS_Type='NB') msma 
		--where
		--(ms.id=msma.id)
		--and ms.MOS_Type='NB'
		---- MOS WB Median

		--select MOS as MOS_MED

		--into #MOS_WB_MED_Indoor
		--from #MOS_MAIN_Indoor ms,
		--	(Select round(MAX(id)*0.5,0) as id
		--		from #MOS_MAIN_Indoor
		--		where MOS_Type='WB') msma 
		--where
		--(ms.id=msma.id)
		--and ms.MOS_Type='WB'

		---- MOS ALL 5th Percentile

		--select MOS as MOS_5

		--into #MOS_ALL_5TH_Indoor
		--from #MOS_MAIN_Indoor ms,
		--	(Select round(MAX(idAll)*0.05,0) as id
		--		from #MOS_MAIN_Indoor) msma 
		--where
		--(ms.idALL=msma.id)

end

--------------------------- MOS Percentile -----------------------------------

------------------------------------------------------------------------------------
------------------------------- GENERAL SELECT
---------------- All Sheet for KPI Voice Aggregated Info Book
------------------------------------------------------------------------------------

if @type = 'M2M' --Sólo las muestras con GPS
begin

select 
SUM (case when v.callDir in ('MO','MT') then 1 else 0 end) as Call_Attemps,
SUM (case when v.callDir in ('MO','MT') and v.callStatus='Failed' then 1 else 0 end) as Access_Failures,

/*sum (case when v.callDir='MO' then 1 else 0 end)*/ null as MO_Attempts,
/*SUM (case when (v.callDir='MO' and v.callStatus='Failed') then 1 else 0 end)*/ null as MO_Fails,
/*sum (case when v.callDir='MT' then 1 else 0 end)*/ null as MT_Attempts,
/*SUM (case when (v.callDir='MT' and v.callStatus='Failed') then 1 else 0 end)*/ null as MT_Fails,
SUM (case when (v.callStatus='Dropped') then 1 else 0 end) as Drops,

/*sum(v.SQNS_NB)*/ null as SQNS_NB,
sum(case when v.callstatus = 'Completed' then v.SQNS_WB end) as SQNS_WB,

/*AVG(case when v.callDir='MO' then v.cst_till_alerting end)/1000.0*/ null as CST_MO_Alerting_AVG,
/*AVG(case when v.callDir='MT' then v.cst_till_alerting end)/1000.0*/ null as CST_MT_Alerting_AVG,
AVG(CAST(case when v.callDir in ('MO','MT') and v.callstatus = 'Completed' then 1.0*v.cst_till_alerting end as Float))/1000.0 as CST_MOMT_Alerting_AVG,
/*(select CST_A_95 from #MO_CST_A)*/ null as CST_MO_Alerting_95th,
/*(select CST_A_95 from #MT_CST_A)*/ null as CST_MT_Alerting_95th,
(select CST_A_95 from #MOMT_CST_A) as CST_MOMT_Alerting_95th,
/*AVG(case when v.callDir='MO' then v.cst_till_connAck end)/1000.0*/ null as CST_MO_Connect_AVG,
/*AVG(case when v.callDir='MT' then v.cst_till_connAck end)/1000.0*/ null as CST_MT_Connect_AVG,
AVG(CAST(case when v.callDir in ('MO','MT') and v.callstatus = 'Completed' then 1.0*v.cst_till_connAck end as Float))/1000.0 as CST_MOMT_Connect_AVG,
/*(select CST_C_95 from #MO_CST_C)*/ null as CST_MO_Connect_95th,
/*(select CST_C_95 from #MT_CST_C)*/ null as CST_MT_Connect_95th,
(select CST_C_95 from #MOMT_CST_C) as CST_MOMT_Connect_95th,

/*AVG(v.MOS_NB)*/ null as MOS_NB_DLUL_AVG,
/*SUM(v.MOS_Samples_NB)*/ null as MOS_NB_Samples,
/*STDEV(v.MOS_NB)*/ null as MOS_NB_DLUL_STDEV,
/*SUM(v.[MOS_NB_Samples_Under_2.5])*/ null as 'MOS_NB_Samples_Under_2.5',
/*(select MOS_5 from #MOS_NB_5TH)*/ null as MOS_NB_5th,

AVG(case when v.callstatus = 'Completed' then CAST(case when (v.MOS_WB is not null) then v.MOS_WB else v.MOS_NB end as Float) end) as  MOS_ALL_DLUL_AVG,
--(AVG(v.MOS_NB)+AVG(v.MOS_WB))/2 as MOS_ALL_DLUL_AVG,
SUM(case when v.callstatus = 'Completed' then(v.MOS_Samples_NB + v.MOS_Samples_WB) end) as MOS_ALL_Samples,
(select MOS from #MOS_ALL_STDEV) as MOS_ALL_DLUL_STDEV,
--STDEV(case when v.callstatus in ('Completed', 'Dropped') then (case when (v.MOS_WB is not null) then v.MOS_WB else v.MOS_NB end) end) as MOS_ALL_DLUL_STDEV,
--STDEV(v.MOS_NB) as MOS_ALL_DLUL_STDEV,
SUM(case when v.callstatus = 'Completed' then (v.[MOS_NB_Samples_Under_2.5] + v.[MOS_WB_Samples_Under_2.5])end) as 'MOS_ALL_Samples_Under_2.5',
(select MOS_5 from #MOS_ALL_5TH) as MOS_ALL_5th,
avg(v.Speech_Delay) as VOLTE_Speech_Delay,

SUM(case when v.callstatus = 'Completed' then (case when v.MOS_Samples_NB = 0 and v.MOS_Samples_WB > 0 then 1 else 0 end)end) as Calls_WB_Only,
AVG(case when v.callstatus = 'Completed' then (CAST(case when v.MOS_Samples_NB = 0 and v.MOS_Samples_WB > 0 then v.MOS_WB end as Float)) end) as MOS_WB_Avg,
case when SUM(case when v.callstatus = 'Completed' then (case when v.MOS_Samples_NB = 0 and v.MOS_Samples_WB > 0 then 1 else 0 end)end)=0 then null else (select MOS_MED from #MOS_WB_MED) end as MOS_WB_Median,

/* DGP 11/02/2015: Se actualiza la forma de contar las llamadas para tener en cuenta los 2 moviles para M2M*/
--SUM(case when (v.Technology = 'UMTS' and v.is_csfb=0 and v.callstatus='Completed') then 1 else 0 end) As Started_Ended_3G,
--SUM(case when (v.Technology = 'GSM' and v.is_csfb=0 and v.callstatus='Completed') then 1 else 0 end) As Started_Ended_2G,
--SUM(case when (v.Technology like '%/%' and v.Technology <> 'LTE' and v.is_csfb=0 and v.callstatus='Completed') then 1 else 0 end) As Calls_Mixed,
--SUM(case when (v.Technology = 'LTE' or v.is_csfb>0) and v.callstatus='Completed' then 1 else 0 end) As Started_4G,
----SUM(case when v.startTechnology like '%UMTS%' and v.endTechnology like '%UMTS%' then v.callDuration else 0 end) as Duration_3G,
----SUM(case when v.startTechnology like '%GSM%' and v.endTechnology like '%GSM%' then v.callDuration else 0 end) as Duration_2G,
--SUM(case when (v.is_csfb>0 and v.cmService_band like 'GSM%' and v.callstatus='Completed') then 1 else 0 end) as GSM_calls_After_CSFB,
--SUM(case when (v.is_csfb>0 and v.cmService_band like 'UMTS%' and v.callstatus='Completed') then 1 else 0 end) as UMTS_calls_After_CSFB,
----SUM(case when (v.is_csfb=1 and (v.technology='LTE/GSM' or v.technology like 'GSM%') and v.callstatus='Completed') then 1 else 0 end) as GSM_calls_After_CSFB,
----SUM(case when (v.is_csfb=1 and (v.technology='LTE/UMTS' or v.technology like 'UMTS%') and v.callstatus='Completed') then 1 else 0 end) as UMTS_calls_After_CSFB

SUM(case 
		when ((left(v.cmservice_band,4) = 'UMTS' and left(v.disconnect_band,4) = 'UMTS' and v.CSFB_Device = '') and (left(v.cmservice_band_B,4) = 'UMTS' and left(v.disconnect_band_B,4) = 'UMTS' and v.CSFB_Device = '') and v.is_csfb=0 and v.callstatus in ('Completed','Dropped')) then 2
		when (((left(v.cmservice_band,4) = 'UMTS' and left(v.disconnect_band,4) = 'UMTS' and v.CSFB_Device <> 'A') or (left(v.cmservice_band_B,4) = 'UMTS' and left(v.disconnect_band_B,4) = 'UMTS' and v.CSFB_Device <> 'B')) and v.is_csfb<2 and v.callstatus in ('Completed','Dropped')) then 1 
		else 0 
		end) As Started_Ended_3G,
SUM(case 
		when ((left(v.cmservice_band,3) = 'GSM' and left(v.disconnect_band,3) = 'GSM' and v.CSFB_Device = '') and (left(v.cmservice_band_B,3) = 'GSM' and left(v.disconnect_band_B,3) = 'GSM' and v.CSFB_Device = '') and v.is_csfb=0 and v.callstatus in ('Completed','Dropped')) then 2
		when (((left(v.cmservice_band,3) = 'GSM' and left(v.disconnect_band,3) = 'GSM' and v.CSFB_Device <> 'A') or (left(v.cmservice_band_B,3) = 'GSM' and left(v.disconnect_band_B,3) = 'GSM' and v.CSFB_Device <> 'B')) and v.is_csfb<2 and v.callstatus in ('Completed','Dropped')) then 1 
		else 0 
		end) As Started_Ended_2G,
SUM(case 
		when (((left(v.cmservice_band,3) <> left(v.disconnect_band,3) and v.CSFB_Device = '') and (left(v.cmservice_band_B,3) <> left(v.disconnect_band_B,3) and v.CSFB_Device = '')) and v.is_csfb=0 and v.callstatus in ('Completed','Dropped')) then 2
		when (((left(v.cmservice_band,3) <> left(v.disconnect_band,3) and v.CSFB_Device <> 'A') or (left(v.cmservice_band_B,3) <> left(v.disconnect_band_B,3) and v.CSFB_Device <> 'B')) and v.is_csfb<2 and v.callstatus in ('Completed','Dropped')) then 1 
		else 0 
		end) As Calls_Mixed,
SUM(case when (v.Technology = 'LTE' or v.Technology_Bside = 'LTE' or v.is_csfb>0 or v.is_VoLTE>0) and v.callstatus in ('Completed','Dropped') then v.is_csfb+v.is_VoLTE else 0 end) As Started_4G,
sum(case when (v.callstatus in ('Completed','Dropped') and (v.is_VoLTE-v.is_SRVCC) >=0) then v.is_VoLTE-v.is_SRVCC else 0 end) as Started_VoLTE,
isnull(SUM(v.UMTS_Duration),0) as Duration_3G,
isnull(SUM(v.GSM_Duration),0) as Duration_2G,
SUM(case 
		when (((v.cmService_band like 'GSM%' and v.CSFB_device like '%A%') and (v.cmService_band_B like 'GSM%' and v.CSFB_device like '%B%')) and v.is_csfb=2 and v.callstatus in ('Completed','Dropped')) then 2 
		when (((v.cmService_band like 'GSM%' and v.CSFB_device = 'A') or (v.cmService_band_B like 'GSM%' and v.CSFB_device = 'B')) and v.is_csfb>0 and v.callstatus in ('Completed','Dropped')) then 1 
		else 0 
		end) as GSM_calls_After_CSFB,
SUM(case 
		when (((v.cmService_band like 'UMTS%' and v.CSFB_device like '%A%') and (v.cmService_band_B like 'UMTS%' and v.CSFB_device like '%B%')) and v.is_csfb=2 and v.callstatus in ('Completed','Dropped')) then 2 
		when (((v.cmService_band like 'UMTS%' and v.CSFB_device = 'A') or (v.cmService_band_B like 'UMTS%' and v.CSFB_device = 'B')) and v.is_csfb>0 and v.callstatus in ('Completed','Dropped')) then 1 
		else 0 
		end) as UMTS_calls_After_CSFB,
sum(case when v.callstatus in ('Completed','Dropped') then v.is_SRVCC end) as SRVCC,
1.0*sum(case when v.callstatus in ('Completed','Dropped') then v.is_SRVCC end)/nullif(sum(case when v.callstatus in ('Completed','Dropped') then v.is_VoLTE end),0) as SRVCC_pct


from 
	#All_Tests a,
	lcc_Calls_Detailed v,
	Sessions s,
	Agrids.dbo.lcc_parcelas lp

where
	a.sessionid=v.Sessionid
	and s.SessionId=v.Sessionid
	and v.callDir <> 'SO'
	and v.callStatus in ('Completed','Failed','Dropped')
	--and v.callStatus <> 'System Release'
	--and v.callStatus <> 'not set'
	and s.valid=1
	and lp.Nombre= master.dbo.fn_lcc_getParcel(v.longitude_fin_A, v.latitude_fin_A)
	and lp.entorno like @Environ
end

else -- Type: M2F (Todos los tests Con GPS o no)
begin

select 
SUM (case when v.callDir in ('MO','MT') then 1 else 0 end) as Call_Attemps,
SUM (case when v.callDir in ('MO','MT') and v.callStatus='Failed' then 1 else 0 end) as Access_Failures,

sum (case when v.callDir='MO' then 1 else 0 end) as MO_Attempts,
SUM (case when (v.callDir='MO' and v.callStatus='Failed') then 1 else 0 end) as MO_Fails,
sum (case when v.callDir='MT' then 1 else 0 end) as MT_Attempts,
SUM (case when (v.callDir='MT' and v.callStatus='Failed') then 1 else 0 end) as MT_Fails,
SUM (case when (v.callStatus='Dropped') then 1 else 0 end) as Drops,

sum(case when v.callstatus = 'Completed' then v.SQNS_NB end) as SQNS_NB,
/*sum(v.SQNS_WB)*/ null as SQNS_WB,

AVG(case when v.callDir='MO' and v.callstatus = 'Completed' then 1.0*v.cst_till_alerting end)/1000.0 as CST_MO_Alerting_AVG,
AVG(case when v.callDir='MT' and v.callstatus = 'Completed' then 1.0*v.cst_till_alerting end)/1000.0 as CST_MT_Alerting_AVG,
AVG(case when v.callDir in ('MO','MT') and v.callstatus = 'Completed' then 1.0*v.cst_till_alerting end)/1000.0 as CST_MOMT_Alerting_AVG,
(select CST_A_95 from #MO_CST_A_Indoor) as CST_MO_Alerting_95th,
(select CST_A_95 from #MT_CST_A_Indoor) as CST_MT_Alerting_95th,
(select CST_A_95 from #MOMT_CST_A_Indoor) as CST_MOMT_Alerting_95th,
AVG(case when v.callDir='MO' and v.callstatus = 'Completed' then 1.0*v.cst_till_connAck end)/1000.0 as CST_MO_Connect_AVG,
AVG(case when v.callDir='MT' and v.callstatus = 'Completed' then 1.0*v.cst_till_connAck end)/1000.0 as CST_MT_Connect_AVG,
AVG(case when v.callDir in ('MO','MT') and v.callstatus = 'Completed' then 1.0*v.cst_till_connAck end)/1000.0 as CST_MOMT_Connect_AVG,
(select CST_C_95 from #MO_CST_C_Indoor) as CST_MO_Connect_95th,
(select CST_C_95 from #MT_CST_C_Indoor) as CST_MT_Connect_95th,
(select CST_C_95 from #MOMT_CST_C_Indoor) as CST_MOMT_Connect_95th,

AVG(case when v.callstatus = 'Completed' then v.MOS_NB end) as MOS_NB_DLUL_AVG,
SUM(case when v.callstatus = 'Completed' then v.MOS_Samples_NB end) as MOS_NB_Samples,
(select MOS from #MOS_NB_STDEV_Indoor) as MOS_NB_DLUL_STDEV,
--STDEV(case when v.callstatus in ('Completed', 'Dropped') then v.MOS_NB end) as MOS_NB_DLUL_STDEV,
SUM(case when v.callstatus = 'Completed' then v.[MOS_NB_Samples_Under_2.5] end) as 'MOS_NB_Samples_Under_2.5',
(select MOS_5 from #MOS_NB_5TH_Indoor) as MOS_NB_5th,

/*(AVG(v.MOS_NB)+AVG(v.MOS_WB))/2*/ null as MOS_ALL_DLUL_AVG,
/*SUM(v.MOS_Samples_NB + v.MOS_Samples_WB)*/ null as MOS_ALL_Samples,
/*STDEV(v.MOS_NB)*/ null as MOS_ALL_DLUL_STDEV,
/*SUM(v.[MOS_NB_Samples_Under_2.5] + v.[MOS_WB_Samples_Under_2.5])*/ null as 'MOS_ALL_Samples_Under_2.5',
/*(select MOS_5 from #MOS_ALL_5TH)*/ null as MOS_ALL_5th,

/*SUM(case when v.MOS_Samples_NB is null and v.MOS_Samples_WB is not null then 1 else 0 end)*/ null as Calls_WB_Only,
/*AVG(v.MOS_WB)*/ null as MOS_WB_Avg,
/*(select MOS_MED from #MOS_WB_MED)*/ null as MOS_WB_Median,


-- DGP 11/02/2015: Se actualiza la forma de contar las llamadas para tener en cuenta los 2 moviles para M2F
--***************************************************************************************************************************
--SUM(case when (v.Technology = 'UMTS' and v.is_csfb=0 and v.callstatus='Completed') then 1 else 0 end) As Started_Ended_3G,
--SUM(case when (v.Technology = 'GSM' and v.is_csfb=0 and v.callstatus='Completed') then 1 else 0 end) As Started_Ended_2G,
--SUM(case when (v.Technology like '%/%' and v.Technology <> 'LTE' and v.is_csfb=0 and v.callstatus='Completed') then 1 else 0 end) As Calls_Mixed,
--SUM(case when (v.Technology = 'LTE' or v.is_csfb>0) and v.callstatus='Completed' then 1 else 0 end) As Started_4G,

----SUM(case when v.startTechnology like '%UMTS%' and v.endTechnology like '%UMTS%' then v.callDuration else 0 end) as Duration_3G,
----SUM(case when v.startTechnology like '%GSM%' and v.endTechnology like '%GSM%' then v.callDuration else 0 end) as Duration_2G,

--isnull(SUM(v.UMTS_Duration),0) as Duration_3G,
--isnull(SUM(v.GSM_Duration),0) as Duration_2G,

----SUM(case when (v.is_csfb=1 and (v.technology='LTE/GSM' or v.technology like 'GSM%') and v.callstatus='Completed') then 1 else 0 end) as GSM_calls_After_CSFB,
----SUM(case when (v.is_csfb=1 and (v.technology='LTE/UMTS' or v.technology like 'UMTS%') and v.callstatus='Completed') then 1 else 0 end) as UMTS_calls_After_CSFB

--SUM(case when (v.is_csfb>0 and v.cmService_band like 'GSM%' and v.callstatus='Completed') then 1 else 0 end) as GSM_calls_After_CSFB,
--SUM(case when (v.is_csfb>0 and v.cmService_band like 'UMTS%' and v.callstatus='Completed') then 1 else 0 end) as UMTS_calls_After_CSFB

SUM(case 
		when ((left(v.cmservice_band,4) = 'UMTS' and left(v.disconnect_band,4) = 'UMTS' and v.CSFB_Device = '') and (left(v.cmservice_band_B,4) = 'UMTS' and left(v.disconnect_band_B,4) = 'UMTS' and v.CSFB_Device = '') and v.is_csfb=0 and v.callstatus in ('Completed','Dropped')) then 2
		when (((left(v.cmservice_band,4) = 'UMTS' and left(v.disconnect_band,4) = 'UMTS' and v.CSFB_Device <> 'A') or (left(v.cmservice_band_B,4) = 'UMTS' and left(v.disconnect_band_B,4) = 'UMTS' and v.CSFB_Device <> 'B')) and v.is_csfb<2 and v.callstatus in ('Completed','Dropped')) then 1 
		else 0 
		end) As Started_Ended_3G,
SUM(case 
		when ((left(v.cmservice_band,3) = 'GSM' and left(v.disconnect_band,3) = 'GSM' and v.CSFB_Device = '') and (left(v.cmservice_band_B,3) = 'GSM' and left(v.disconnect_band_B,3) = 'GSM' and v.CSFB_Device = '') and v.is_csfb=0 and v.callstatus in ('Completed','Dropped')) then 2
		when (((left(v.cmservice_band,3) = 'GSM' and left(v.disconnect_band,3) = 'GSM' and v.CSFB_Device <> 'A') or (left(v.cmservice_band_B,3) = 'GSM' and left(v.disconnect_band_B,3) = 'GSM' and v.CSFB_Device <> 'B')) and v.is_csfb<2 and v.callstatus in ('Completed','Dropped')) then 1 
		else 0 
		end) As Started_Ended_2G,
SUM(case 
		when (((left(v.cmservice_band,3) <> left(v.disconnect_band,3) and v.CSFB_Device = '') and (left(v.cmservice_band_B,3) <> left(v.disconnect_band_B,3) and v.CSFB_Device = '')) and v.is_csfb=0 and v.callstatus in ('Completed','Dropped')) then 2
		when (((left(v.cmservice_band,3) <> left(v.disconnect_band,3) and v.CSFB_Device <> 'A') or (left(v.cmservice_band_B,3) <> left(v.disconnect_band_B,3) and v.CSFB_Device <> 'B')) and v.is_csfb<2 and v.callstatus in ('Completed','Dropped')) then 1 
		else 0 
		end) As Calls_Mixed,
SUM(case when (v.Technology = 'LTE' or v.Technology_Bside = 'LTE' or v.is_csfb>0 or v.is_VoLTE>0) and v.callstatus in ('Completed','Dropped') then v.is_csfb+v.is_VOLTE else 0 end) As Started_4G,
isnull(SUM(v.UMTS_Duration),0) as Duration_3G,
isnull(SUM(v.GSM_Duration),0) as Duration_2G,
SUM(case 
		when (((v.cmService_band like 'GSM%' and v.CSFB_device like '%A%') and (v.cmService_band_B like 'GSM%' and v.CSFB_device like '%B%')) and v.is_csfb=2 and v.callstatus in ('Completed','Dropped')) then 2 
		when (((v.cmService_band like 'GSM%' and v.CSFB_device = 'A') or (v.cmService_band_B like 'GSM%' and v.CSFB_device = 'B')) and v.is_csfb>0 and v.callstatus in ('Completed','Dropped')) then 1 
		else 0 
		end) as GSM_calls_After_CSFB,
SUM(case 
		when (((v.cmService_band like 'UMTS%' and v.CSFB_device like '%A%') and (v.cmService_band_B like 'UMTS%' and v.CSFB_device like '%B%')) and v.is_csfb=2 and v.callstatus in ('Completed','Dropped')) then 2 
		when (((v.cmService_band like 'UMTS%' and v.CSFB_device = 'A') or (v.cmService_band_B like 'UMTS%' and v.CSFB_device = 'B')) and v.is_csfb>0 and v.callstatus in ('Completed','Dropped')) then 1 
		else 0 
		end) as UMTS_calls_After_CSFB


from 
	#All_Tests a,
	lcc_Calls_Detailed v,
	Sessions s/*,
	Agrids.dbo.lcc_parcelas lp*/

where
	a.sessionid=v.Sessionid
	and s.SessionId=v.Sessionid
	and v.callDir <> 'SO'
	and v.callStatus in ('Completed','Failed','Dropped')
	--and v.callStatus <> 'System Release'
	--and v.callStatus <> 'not set'
	and s.valid=1
	--and lp.Nombre= master.dbo.fn_lcc_getParcel(v.longitude_fin_A, v.latitude_fin_A)

end


if @type = 'M2M' --Sólo las muestras con GPS
begin
drop table #all_Tests, #CST_MAIN,#MO_CST_A, #MT_CST_A, #MOMT_CST_A, #MO_CST_C, #MT_CST_C, #MOMT_CST_C, #MOS_MAIN,#MOS_ALL_5TH,#MOS_NB_5TH,#MOS_WB_MED, #CST_perc, #MOS_perc, #MOS_ALL_STDEV
end

else

begin
drop table #all_Tests, #CST_MAIN_Indoor,#MO_CST_A_Indoor, #MT_CST_A_Indoor, #MOMT_CST_A_Indoor, #MO_CST_C_Indoor, #MT_CST_C_Indoor, #MOMT_CST_C_Indoor, #MOS_MAIN_Indoor,#MOS_ALL_5TH_Indoor,#MOS_NB_5TH_Indoor,#MOS_WB_MED_Indoor, #CST_perc_Indoor, #MOS_perc_Indoor, #MOS_NB_STDEV_Indoor
end
GO

