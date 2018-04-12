IF object_ID(N'[dbo].[sp_MDD_Voice_Libro_Blocked_Calls]') IS NOT NULL
              DROP PROCEDURE [dbo ].[sp_MDD_Voice_Libro_Blocked_Calls]
GO
CREATE PROCEDURE [dbo].[sp_MDD_Voice_Libro_Blocked_Calls] (
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
				@type as varchar(256),
				@Date as varchar (256),
				@TechF as varchar (256),
				@Environ as varchar (256)
				)
AS

-----------------------------
----- Testing Variables -----
-----------------------------
--declare @mob1 as varchar(256) = '355828061803206'
--declare @mob2 as varchar(256) = '355828061804360'
--declare @mob3 as varchar(256) = 'Ninguna'

--declare @fecha_ini_text1 as varchar (256) = '2015-02-15 00:00:00:000'
--declare @fecha_fin_text1 as varchar (256) = '2015-02-28 23:59:59:000'
--declare @fecha_ini_text2 as varchar (256) = '2015-01-13 20:11:00:000'
--declare @fecha_fin_text2 as varchar (256) = '2015-01-13 20:11:00:000'
--declare @fecha_ini_text3 as varchar (256) = '2014-08-20 13:33:00:000'
--declare @fecha_fin_text3 as varchar (256) = '2014-08-20 13:33:00:000'
--declare @fecha_ini_text4 as varchar (256) = '2014-06-23 18:30:00:000'
--declare @fecha_fin_text4 as varchar (256) = '2014-06-23 18:30:00:000'
--declare @fecha_ini_text5 as varchar (256) = '2014-06-23 18:30:00:000'
--declare @fecha_fin_text5 as varchar (256) = '2014-06-23 18:30:00:000'
--declare @fecha_ini_text6 as varchar (256) = '2014-06-23 18:30:00:000'
--declare @fecha_fin_text6 as varchar (256) = '2014-06-23 18:30:00:000'
--declare @fecha_ini_text7 as varchar (256) = '2014-08-07 10:40:00:000'
--declare @fecha_fin_text7 as varchar (256) = '2014-08-07 10:40:00:000'
--declare @fecha_ini_text8 as varchar (256) = '2014-08-12 09:40:00:000'
--declare @fecha_fin_text8 as varchar (256) = '2014-08-12 09:40:00:000'
--declare @fecha_ini_text9 as varchar (256) = '2014-08-12 09:40:00:000'
--declare @fecha_fin_text9 as varchar (256) = '2014-08-12 09:40:00:000'
--declare @fecha_ini_text10 as varchar (256) = '2014-08-12 09:40:00:000'
--declare @fecha_fin_text10 as varchar (256) = '2014-08-12 09:40:00:000'


--declare @ciudad as varchar(256) = 'Madrid'
--declare @simOperator as int = 1
--declare @Date as varchar(256) = ''
--declare @TechF as varchar(256) = ''
--declare @type as varchar(256) = 'M2M'

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
from lcc_Calls_Detailed v
Where v.collectionname like @Date + '%' + @ciudad + '%' + @TechF
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



------------------------------------------------------------------------------------
------------------------------- GENERAL SELECT
-------------------- Block Calls Disaggregated Info Book
------------------------------------------------------------------------------------
  
select  v.Sessionid,
		v.ASideFileName as LogFile,
		v.imei,
		v.callDir as CallDirection,
		v.calltype,
		v.MCC as Country,
		v.MNC as Operator,
		v.callStartTimeStamp as LogDate,
		v.callStartTimeStamp as StartDate,
		v.callEndTimeStamp as BlockDate,
		v.callDuration as Duration,
		v.codeDescription as Cause,
		v.is_CSFB as Is_CSFB_Call,
		v.CMService_UARFCN,
		v.CMService_Band,
		v.Alerting_UARFCN,
		v.Alerting_Band,
		v.Connect_UARFCN,
		v.Connect_Band,
		v.Disconnect_UARFCN,
		v.Disconnect_Band,
		v.technology as Technology,
		v.Hopping,
		v.StartTechnology,
		v.[LAC/TAC_Ini] as Initial_LAC,
		v.CellId_Ini as Initial_CellId,
		case when v.StartTechnology like '%GSM%' then v.BSIC_Ini
			 when v.StartTechnology like '%UMTS%' then v.PSC_Ini
			 when v.StartTechnology like '%LTE%' then v.PCI_Ini
			 end as Initial_BSIC_PSC_PCI,
		case when v.StartTechnology like '%GSM%' then v.BCCH_Ini
			 when v.StartTechnology like '%UMTS%' then v.UARFCN_Ini
			 when v.StartTechnology like '%LTE%' then v.EARFCN_Ini
			 end as Initial_BCCH_UARFCN_EARFCN,
		--v.UARFCN_Ini as Initial_UARFCN,
		v.RNC_Ini as Initial_RNC,
		case when v.StartTechnology like '%GSM%' then v.RxLev_Ini
			 when v.StartTechnology like '%UMTS%' then v.RSCP_Ini
			 when v.StartTechnology like '%LTE%' then v.RSRP_Ini
			 end as Initial_SS,
		case when v.StartTechnology like '%GSM%' then v.RxQual_Ini
			 when v.StartTechnology like '%UMTS%' then v.EcIo_Ini
			 when v.StartTechnology like '%LTE%' then v.RSRQ_Ini
			 end as Initial_SQ,
		case when v.StartTechnology like '%LTE%' then v.SINR_Aside_ini end as SINR_Ini,
		v.EndTechnology,
		v.[LAC/TAC_Fin] as Final_LAC,
		v.CellId_Fin as Final_CellId,
		case when v.EndTechnology like '%GSM%' then v.BSIC_Fin
			 when v.EndTechnology like '%UMTS%' then v.PSC_Fin
			 when v.EndTechnology like '%LTE%' then v.PCI_Fin
			 end as Final_BSIC_PSC_PCI,
		case when v.EndTechnology like '%GSM%' then v.BCCH_Ini
			 when v.EndTechnology like '%UMTS%' then v.UARFCN_Ini
			 when v.EndTechnology like '%LTE%' then v.EARFCN_Ini
			 end as Final_BCCH_UARFCN_EARFCN,
		--v.UARFCN_Fin as Final_UARFCN,
		v.RNC_Fin as Final_RNC,
		case when v.EndTechnology like '%GSM%' then v.RxLev_Fin
			 when v.EndTechnology like '%UMTS%' then v.RSCP_Fin
			 when v.StartTechnology like '%LTE%' then v.RSRP_Fin
			 end as Final_SS,
		case when v.EndTechnology like '%GSM%' then v.RxQual_Fin
			 when v.EndTechnology like '%UMTS%' then v.EcIo_Fin
			 when v.EndTechnology like '%LTE%' then v.RSRQ_Fin
			 end as Final_SQ,
		case when v.EndTechnology like '%LTE%' then v.SINR_Aside_fin end as SINR_Fin,
		v.average_technology as Average_Technology,
		case when v.average_technology like '%GSM%' then v.RxLev
			 when v.average_technology like '%UMTS%' then v.RSCP
			 when v.average_technology like '%LTE%' then v.RSRP
			 end as Average_SS,
		case when v.average_technology like '%GSM%' then v.RxQual
			 when v.average_technology like '%UMTS%' then v.EcIo
			 when v.average_technology like '%LTE%' then v.RSRQ
			 end as Average_SQ,
		case when v.average_technology like '%LTE%' then v.SINR_Aside end as Average_SINR,
		case when v.average_technology like '%GSM%' then v.N1_RxLev
			 when v.average_technology like '%UMTS%' then v.N1_RSCP
			-- when v.average_technology like '%LTE%' then v.N1_RSRP
			 end as Neighbor1_SS,
		case when v.average_technology like '%GSM%' then v.RxLev_min
			 when v.average_technology like '%UMTS%' then v.RSCP_Min
			-- when v.average_technology like '%LTE%' then v.RSRP_Min
			 end as Min_SS,
		case when v.average_technology like '%GSM%' then v.RxQual_min
			 when v.average_technology like '%UMTS%' then v.EcIo_min
			 --when v.average_technology like '%LTE%' then v.RSRQ_Min
			 end as Worst_SQ,
		v.Fast_Return_Duration,
		v.Fast_Return_Freq_Dest,
		v.longitude_Ini_A as Initial_Longitude_A,
		v.latitude_Ini_A as Initial_Latitude_A,
		v.longitude_Ini_B as Initial_Longitude_B,
		v.latitude_Ini_B as Initial_Latitude_B,
		v.longitude_Fin_A as Final_Longitude_A,
		v.latitude_Fin_A as Final_Latitude_A,
		v.longitude_Fin_B as Final_Longitude_B,
		v.latitude_Fin_B as Final_Latitude_B,
		DB_name() as DDBB,
		v.is_VoLTE as Volte,
		v.Speech_Delay as [Volte Speech Delay],
		v.is_SRVCC as SRVCC,
		v.technology_BSide,
		v.CMService_UARFCN_B,
		v.CMService_Band_B,
		v.Alerting_UARFCN_B,
		v.Alerting_Band_B,
		v.Connect_UARFCN_B,
		v.Connect_Band_B,
		v.Disconnect_UARFCN_B,
		v.Disconnect_Band_B,
		v.Hopping_BSide,
		v.StartTechnology_BSide,
		v.[LAC/TAC_Ini_BSide] as Initial_LAC_BSide,
		v.CellId_Ini_BSide as Initial_CellId_BSide,
		case when v.StartTechnology_BSide like '%GSM%' then v.BSIC_Ini_BSide
			 when v.StartTechnology_BSide like '%UMTS%' then v.PSC_Ini_BSide
			 when v.StartTechnology_BSide like '%LTE%' then v.PCI_Ini_BSide
			 end as Initial_BSIC_PSC_PCI_BSide,
		case when v.StartTechnology_BSide like '%GSM%' then v.BCCH_Ini_BSide
			 when v.StartTechnology_BSide like '%UMTS%' then v.UARFCN_Ini_BSide
			 when v.StartTechnology_BSide like '%LTE%' then v.EARFCN_Ini_BSide
			 end as Initial_BCCH_UARFCN_EARFCN_BSide,
		--v.UARFCN_Ini as Initial_UARFCN,
		v.RNC_Ini_BSide as Initial_RNC_BSide,
		case when v.StartTechnology_BSide like '%GSM%' then v.RxLev_Ini_BSide
			 when v.StartTechnology_BSide like '%UMTS%' then v.RSCP_Ini_BSide
			 when v.StartTechnology_BSide like '%LTE%' then v.RSRP_Ini_BSide
			 end as Initial_SS_BSide,
		case when v.StartTechnology_BSide like '%GSM%' then v.RxQual_Ini_BSide
			 when v.StartTechnology_BSide like '%UMTS%' then v.EcIo_Ini_BSide
			 when v.StartTechnology_BSide like '%LTE%' then v.RSRQ_Ini_BSide
			 end as Initial_SQ_BSide,
		case when v.StartTechnology_BSide like '%LTE%' then v.SINR_Bside_ini end as SINR_Ini_BSide,
		v.EndTechnology_BSide,
		v.[LAC/TAC_Fin_BSide] as Final_LAC_BSide,
		v.CellId_Fin_BSide as Final_CellId_BSide,
		case when v.EndTechnology_BSide like '%GSM%' then v.BSIC_Fin_BSide
			 when v.EndTechnology_BSide like '%UMTS%' then v.PSC_Fin_BSide
			 when v.EndTechnology_BSide like '%LTE%' then v.PCI_Fin_BSide
			 end as Final_BSIC_PSC_PCI_BSide,
		case when v.EndTechnology_BSide like '%GSM%' then v.BCCH_Ini_BSide
			 when v.EndTechnology_BSide like '%UMTS%' then v.UARFCN_Ini_BSide
			 when v.EndTechnology_BSide like '%LTE%' then v.EARFCN_Ini_BSide
			 end as Final_BCCH_UARFCN_EARFCN_BSide,
		--v.UARFCN_Fin as Final_UARFCN,
		v.RNC_Fin as Final_RNC_BSide,
		case when v.EndTechnology_BSide like '%GSM%' then v.RxLev_Fin_BSide
			 when v.EndTechnology_BSide like '%UMTS%' then v.RSCP_Fin_BSide
			 when v.StartTechnology_BSide like '%LTE%' then v.RSRP_Fin_BSide
			 end as Final_SS_BSide,
		case when v.EndTechnology_BSide like '%GSM%' then v.RxQual_Fin_BSide
			 when v.EndTechnology_BSide like '%UMTS%' then v.EcIo_Fin_BSide
			 when v.EndTechnology_BSide like '%LTE%' then v.RSRQ_Fin_BSide
			 end as Final_SQ_BSide,
		case when v.EndTechnology_BSide like '%LTE%' then v.SINR_Bside_fin end as SINR_Fin_BSide,
		v.average_technology_B as Average_Technology_B,
		case when v.average_technology_B like '%GSM%' then v.RxLev_BSide
			 when v.average_technology_B like '%UMTS%' then v.RSCP_BSide
			 when v.average_technology_B like '%LTE%' then v.RSRP_BSide
			 end as Average_SS_BSide,
		case when v.average_technology_B like '%GSM%' then v.RxQual_BSide
			 when v.average_technology_B like '%UMTS%' then v.EcIo_BSide
			 when v.average_technology_B like '%LTE%' then v.RSRQ_BSide
			 end as Average_SQ_BSide,
		case when v.average_technology_B like '%LTE%' then v.SINR_Bside end as Average_SINR_BSide,
		v.CSFB_Device,
		v.RTP_Jitter_DL,
		v.RTP_Jitter_UL,
		v.RTP_Delay_DL,
		v.RTP_Delay_UL,
		v.RTP_Jitter_DL_BSide,
		v.RTP_Jitter_UL_BSide,
		v.RTP_Delay_DL_BSide,
		v.RTP_Delay_UL_BSide,
		v.Paging_Success_Ratio,
		v.Paging_Success_Ratio_BSide,
		v.PDP_Activate_Ratio,
		v.PDP_Activate_Ratio_BSide,
		v.EARFCN_N1,
		v.PCI_N1,
		v.RSRP_N1,
		v.RSRQ_N1,
		v.EARFCN_N1_BSide,
		v.PCI_N1_BSide,
		v.RSRP_N1_BSide,
		v.RSRQ_N1_BSide,
		v.SRVCC_SR,
		v.SRVCC_SR_BSide,
		v.IRAT_HO2G3G_Ratio,
		v.IRAT_HO2G3G_Ratio_BSide,
		v.num_HO_S1X2,
		v.duration_S1X2_avg,
		v.S1X2HO_SR,
		v.num_HO_S1X2_BSide,
		v.duration_S1X2_avg_BSide,
		v.S1X2HO_SR_BSide,
		v.IMSI	
		
into #final
from 
		#All_Tests a,
		lcc_Calls_Detailed v,
		Sessions s

where
		a.Sessionid=v.Sessionid
		and s.sessionid=v.Sessionid
		and v.callDir <> 'SO'
		and v.callStatus='failed'
		and s.valid=1
order by v.callEndTimeStamp

-- DGP 20/11/2015:
-- Separamos los resultados por tipo de scope:
-- BenchMarkers: Sólo se muestran los tests con GPS
-- FreeRiders: Se muestran todos los tests, y se añade la info de GPS a los que tengan

if (db_name() like '%Indoor%' or db_name() like '%AVE%')
begin
	select  f.*,
			lp.nombre as Parcela,
			lp.Region,
			lp.provincia as Provincia,
			lp.entorno as Entorno,
			lp.entorno_TLT as Entorno_TLT,
			lp.ciudad as Ciudad,
			lp.condado as Condado
		into #BI	
		from #final f
			LEFT OUTER JOIN	Agrids.dbo.lcc_parcelas lp on (lp.Nombre=master.dbo.fn_lcc_getParcel(f.Final_Longitude_A, f.Final_Latitude_A))

select * from #BI 
order by BlockDate

drop table #All_Tests,#final,#BI
end

else
begin
	select  f.*,
			lp.nombre as Parcela,
			lp.Region,
			lp.provincia as Provincia,
			lp.entorno as Entorno,
			lp.entorno_TLT as Entorno_TLT,
			lp.ciudad as Ciudad,
			lp.condado as Condado
		into #B	
		from #final f, Agrids.dbo.lcc_parcelas lp 
		where lp.Nombre=master.dbo.fn_lcc_getParcel(f.Final_Longitude_A, f.Final_Latitude_A)
		and lp.entorno like @Environ

select * from #B 
order by BlockDate

drop table #All_Tests,#final,#B
end


GO

