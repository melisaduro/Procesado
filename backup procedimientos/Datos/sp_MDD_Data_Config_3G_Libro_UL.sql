USE [master]
GO
/****** Object:  StoredProcedure [dbo].[sp_MDD_Data_Config_3G_Libro_UL]    Script Date: 21/12/2016 16:44:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--IF object_ID(N'[dbo].[sp_MDD_Data_Config_3G_Libro_UL]') IS NOT NULL
--              DROP PROCEDURE [dbo ].[sp_MDD_Data_Config_3G_Libro_UL]
--GO

ALTER PROCEDURE [dbo].[sp_MDD_Data_Config_3G_Libro_UL] (
	 --Variables de entrada
				@mob1 as varchar(256),
				@mob2 as varchar(256),
				@mob3 as varchar(256),
				@provincia as varchar(256),			-- si NED: '%%',	si paso1: valor
				@ciudad as varchar(256),			-- si NED: valor,	si paso1: '%%'
				@simOperator as int,
				@sheet as varchar(256),				-- '%%' en 3G				
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
				@Date as varchar (256),
				@Tech as varchar (256),  -- Para seleccionar entre 3G, 4G y CA
				@Environ as varchar (256)
				)
AS


-- **********************************************************************************************************************************************	
--		CODIGO QUE CREA EL LIBRO EXTERNO DE UL:
--
--	Se cojen los TEST IDs correspondientes a las fechas e imes de cada una de la tabla del HTTP Transfer UL
--	
--	CONFIG 3G indica la CONFIGURACION DEL EQUIPO de medida !!!
--		NO se filtra por tecnologia para poder verificar que el equipo de medida estaba debidamente forzado
--
--	Se trata de un select a la tabla general
--	Se linka con TestInfo para obtener solo los test validos
--
-- **********************************************************************************************************************************************	

-----------------------------
----- Testing Variables -----
-------------------------------
--declare @mob1 as varchar(256) = '354720054742312'
--declare @mob2 as varchar(256) = 'Ninguna'
--declare @simOperator as int = 1


---------- Movistar Youtube
--------declare @mob1 as varchar(256) = '355828061803180'
--------declare @mob2 as varchar(256) = '357506057669256'
--------declare @simOperator as int = 7

---------- Orange Latencias
--------declare @mob1 as varchar(256) = '355828061804360'
--------declare @mob2 as varchar(256) = 'Ninguna'
--------declare @simOperator as int = 3

--declare @mob3 as varchar(256) = 'Ninguna'

--declare @fecha_ini_text1 as varchar (256) = '2015-06-02 12:00:00:000'
--declare @fecha_fin_text1 as varchar (256) = '2015-06-02 14:28:00:000'
--declare @fecha_ini_text2 as varchar (256) = '2015-06-02 15:38:00:000'
--declare @fecha_fin_text2 as varchar (256) = '2015-06-02 18:02:00:000'
--declare @fecha_ini_text3 as varchar (256) = '2015-06-02 23:59:59:000'
--declare @fecha_fin_text3 as varchar (256) = '2015-06-02 23:59:59:000'
--declare @fecha_ini_text4 as varchar (256) = '2015-06-02 23:59:59:000'
--declare @fecha_fin_text4 as varchar (256) = '2015-06-02 23:59:59:000'
--declare @fecha_ini_text5 as varchar (256) = '2015-06-02 23:59:59:000'
--declare @fecha_fin_text5 as varchar (256) = '2015-06-02 23:59:59:000'
--declare @fecha_ini_text6 as varchar (256) = '2015-06-02 23:59:59:000'
--declare @fecha_fin_text6 as varchar (256) = '2015-06-02 23:59:59:000'
--declare @fecha_ini_text7 as varchar (256) = '2015-06-02 23:59:59:000'
--declare @fecha_fin_text7 as varchar (256) = '2015-06-02 23:59:59:000'
--declare @fecha_ini_text8 as varchar (256) = '2015-06-02 23:59:59:000'
--declare @fecha_fin_text8 as varchar (256) = '2015-06-02 23:59:59:000'
--declare @fecha_ini_text9 as varchar (256) = '2015-06-02 23:59:59:000'
--declare @fecha_fin_text9 as varchar (256) = '2015-06-02 23:59:59:000'
--declare @fecha_ini_text10 as varchar (256) = '2015-06-02 23:59:59:000'
--declare @fecha_fin_text10 as varchar (256) = '2015-06-02 23:59:59:000'

--declare @provincia as varchar(256) = '%%'
--declare @ciudad as varchar(256) = '%%'

--declare @sheet as varchar(256) = '%%'

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
--	FILTRO GLOBAL		-------------------
-------------------------------------------------------------------------------		
--- UL - #All_Tests_UL
select v.sessionid, v.testid, 
	case when v.[% LTE]=1 then 'LTE'
		 when v.[% WCDMA]=1 then 'WCDMA'
	else 'Mixed' end as tech,
	v.[Longitud Final], v.[Latitud Final]
into #All_Tests_UL
from Lcc_Data_HTTPTransfer_UL v
Where v.collectionname like @Date + '%' + @ciudad + '%' + @Tech
	and v.info='completed' --DGP 17/09/2015: Filtramos solo los tests marcados como completados
	and v.MNC = @simOperator	--MNC
	and v.MCC= 214						--MCC - Descartamos los valores erróneos	
	--and (v.startTime between @fecha_ini1 and @fecha_fin1 
	--		 or
	--		 v.startTime between @fecha_ini2 and @fecha_fin2 
	--		 or
	--		 v.startTime between @fecha_ini3 and @fecha_fin3 
	--		 or
	--		 v.startTime between @fecha_ini4 and @fecha_fin4 
	--		 or
	--		 v.startTime between @fecha_ini5 and @fecha_fin5 
	--		 or
	--		 v.startTime between @fecha_ini6 and @fecha_fin6
 --			 or
	--		 v.startTime between @fecha_ini7 and @fecha_fin7 
 --			 or
	--		 v.startTime between @fecha_ini8 and @fecha_fin8 
 --			 or
	--		 v.startTime between @fecha_ini9 and @fecha_fin9 
 --			 or
	--		 v.startTime between @fecha_ini10 and @fecha_fin10 			 
	--		 or
	--		 v.endTime between @fecha_ini1 and @fecha_fin1 
	--		 or
	--		 v.endTime between @fecha_ini2 and @fecha_fin2 
	--		 or
	--		 v.endTime between @fecha_ini3 and @fecha_fin3 
	--		 or
	--		 v.endTime between @fecha_ini4 and @fecha_fin4 
	--		 or
	--		 v.endTime between @fecha_ini5 and @fecha_fin5 
	--		 or
	--		 v.endTime between @fecha_ini6 and @fecha_fin6
 --			 or
	--		 v.endTime between @fecha_ini7 and @fecha_fin7 
 --			 or
	--		 v.endTime between @fecha_ini8 and @fecha_fin8 
 --			 or
	--		 v.endTime between @fecha_ini9 and @fecha_fin9 
 --			 or
	--		 v.endTime between @fecha_ini10 and @fecha_fin10 			 
	--     )



-------------------------------------------------------------------------------
--	GENERAL SELECT		-------------------	  
-------------------------------------------------------------------------------
select  
	v.IMEI,
	v.testid,
	v.CollectionName as LogFile,
	'Packet Switched data call' as TipoMedidas,
	v.MCC as Pais,
	v.MNC as Operador,
	v.startDate as Fecha,
	v.startTime as InicioDescarga,
	v.endTime as FinDescarga,
	v.[Longitud Final] as Longitud,
	v.[Latitud Final] as Latitud,
	v.DataTransferred,
	v.Throughput*1000.0 as 'Throughput',	-- salia en bps
	v.ErrorCause as Cause,
	case when v.Testtype='UL_CE' then 'Customer Experience'
		 when v.Testtype='UL_NC' then 'Network Capability'
	else null end as TestType,
	v.ErrorType,
	v.ServiceType,
	v.[IP Access Time (ms)],
	v.[% LTE] as DatamodeUL_LTE,
	v.[% WCDMA] as DatamodeUL_HSUPA, 
	v.[% GSM] as DatamodeUL_GSM,
	v.[% U2100] as DatamodeUL_U2100,
    v.[% U900] as DatamodeUL_U900,
	v.[% F1 U2100],
    v.[% F2 U2100],
    v.[% F3 U2100],
    v.[% F1 U900],
    v.[% F2 U900],
	v.TransferTime,
	v.SessionTime,
	v.carriers,
	v.[% Dual Carrier],
	v.[Serving Grant],
	v.DTX,
	v.[% SF22],
	v.[% SF22andSF42],
	v.[% SF4],
	v.[% SF42],
	v.[% TTI 2ms],
	v.[% SHO],
	v.HappyRate,
	v.[avg TBs size] as TBs,
	v.[Longitud Inicial],
	v.[Latitud Inicial],
	v.[RSCP_avg] as 'RSCP Avg',
	v.[EcI0_avg] as 'EcI0 Avg',
	v.[RSCP_Ini] as 'RSCP Inicial',
	v.[RSCP_Fin] as 'RSCP Final',
	v.[EcIo_Ini] as 'EcI0 Inicial',
	v.[EcIo_Fin] as 'EcI0 Final',
	v.[PSC_Ini] as 'SC Inicial',
	v.[PSC_Fin] as 'SC Final',
	v.[LAC/TAC_Ini] as 'LAC Inicial',
	v.[LAC/TAC_Fin] as 'LAC Final',
	v.[UARFCN_Ini] as 'UARFCN Inicial',
	v.[UARFCN_Fin] as 'UARFCN Final',
	v.[CellId_Ini] as 'CellID Inicial',
	v.[CellId_Fin] as 'CellID Final',
	v.[% Dual Carrier U2100],
	v.[% Dual Carrier U900],
	v.[UL_Interference],
	v.Paging_Success_Ratio,
	v.PDP_Activate_Ratio,
	v.Max_Window_Size,
	v.IMSI,
	DB_name() as DDBB

into #final	
from 
	TestInfo t,
	#All_Tests_UL a,
	Lcc_Data_HTTPTransfer_UL v

where	
	a.SessionId=t.SessionId and a.TestId=t.TestId
	and t.valid=1
	and t.Sessionid=v.Sessionid and t.TestId=v.TestId
	 
order by v.endTime

-- DGP 23/11/2015: Se le aplica el filtro por GPS a las medidas de BenchMarker

----------------------------
-- Añadimos Info de parcelas

if (db_name() like '%Indoor%' or db_name() like '%AVE%')
begin
	select  f.*,
			lp.nombre as Parcela,
			lp.Region,
			lp.provincia as Provincia,
			lp.entorno as Entorno,
			--lp.entorno_TLT as Entorno_NED,
			lp.ciudad as Ciudad,
			lp.condado as Condado
		into #VI	
		from #final f
			LEFT OUTER JOIN	Agrids.dbo.lcc_parcelas lp on  lp.Nombre=master.dbo.fn_lcc_getParcel(f.Longitud, f.Latitud)


	select * from #VI 
	order by FinDescarga

	drop table #All_Tests_UL, #VI, #final
end

else
begin
	select  f.*,
			lp.nombre as Parcela,
			lp.Region,
			lp.provincia as Provincia,
			lp.entorno as Entorno,
			--lp.entorno_TLT as Entorno_NED,
			lp.ciudad as Ciudad,
			lp.condado as Condado
		into #V	
		from #final f, Agrids.dbo.lcc_parcelas lp 
		where  lp.Nombre=master.dbo.fn_lcc_getParcel(f.Longitud, f.Latitud)
		and lp.entorno like @Environ


	select * from #V 
	order by FinDescarga

	drop table #All_Tests_UL, #V, #final
end


-------------------------------------------------------------------------------
--	Borrado Tablas		-------------------	  
-------------------------------------------------------------------------------
--drop table #All_Tests_UL, #V, #final


