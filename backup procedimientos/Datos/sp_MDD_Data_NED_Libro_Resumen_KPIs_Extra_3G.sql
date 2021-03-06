USE [master]
GO
/****** Object:  StoredProcedure [dbo].[sp_MDD_Data_NED_Libro_Resumen_KPIs_Extra_3G]    Script Date: 21/12/2016 16:42:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--IF object_ID(N'[dbo].[sp_MDD_Data_NED_Libro_Resumen_KPIs_Extra_3G]') IS NOT NULL
--              DROP PROCEDURE [dbo ].[sp_MDD_Data_NED_Libro_Resumen_KPIs_Extra_3G]
--GO

create PROCEDURE [dbo].[sp_MDD_Data_NED_Libro_Resumen_KPIs_Extra_3G] (
	 --Variables de entrada
				@mob1 as varchar(256),
				@mob2 as varchar(256),
				@mob3 as varchar(256),
				@provincia as varchar(256),			-- si NED: '%%',	si paso1: valor
				@ciudad as varchar(256),			-- si NED: valor,	si paso1: '%%'
				@simOperator as int,
				@sheet as varchar(256),				-- all: %%, 4H: 'LTE', 3G: 'WCDMA'
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
				@Tech as varchar (256),   -- Para seleccionar entre 3G, 4G y CA
				@Environ as varchar (256)	
				)
AS


-- **********************************************************************************************************************************************	
--		CODIGO QUE CREA LAS PESTAÑAS DEL DASHBOARD con la informacion de los KPIs Extra:
--
--	Se cojen los TEST IDs correspondientes a las fechas e imes de cada una de las tablas por servicio disponible
--	
--	Se realizan todos los filtrados al inicio del codigo a la hora de sacar los test de las tablas generales existentes:
--		Filtrado por pagina del dashboard - tecnologia
--		Filtrado por ciudad		- NED
--		Filtrado por provincia	- paso1
--
--
-- **********************************************************************************************************************************************	

-- select distinct imei, mnc from Lcc_Data_HTTPTransfer_DL
---------------------------
--- Testing Variables -----
-----------------------------
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


---------------------------
--- Date Declarations -----
---------------------------	
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
--	FILTROS GLOBALES:
-------------------------------------------------------------------------------		
--- DL - #All_Tests_DL
select v.sessionid, v.testid,
	case when v.[% LTE]=1 then 'LTE'
		 when v.[% WCDMA]=1 then 'WCDMA'
	else 'Mixed' end as tech,
	v.[Longitud Final], v.[Latitud Final]
into #All_Tests_DL_Tech
from Lcc_Data_HTTPTransfer_DL v
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

--- UL - #All_Tests_UL
select v.sessionid, v.testid, 
	case when v.[% LTE]=1 then 'LTE'
		 when v.[% WCDMA]=1 then 'WCDMA'
	else 'Mixed' end as tech,
	v.[Longitud Final], v.[Latitud Final]
into #All_Tests_UL_Tech
from Lcc_Data_HTTPTransfer_UL v
Where v.collectionname like @Date +'%' + @ciudad + '%' + @Tech
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
	     

-- Juntamos todos los id:
select * into #All_Tests_all_Tech from #All_Tests_DL_Tech union all
select * from #All_Tests_UL_Tech 


-- En funcion de la pestaña que sea, se filtra por la tecnologia de interes
--	declare @sheet as varchar(256) = 'LTE'
select * into #All_Tests from #All_Tests_all_Tech where tech like @sheet


------------------------------------------------------------------------------------
------------------------------- SELECT GENERAL
---------------- All Sheet for KPI dATA Aggregated Info Book
-- DGP 23/11/2015: Se le aplica el filtro por GPS a las medidas de BenchMarker
------------------------------------------------------------------------------------

if (db_name() like '%Indoor%' or db_name() like '%AVE%')
begin
select 
	-- DOWNLINK CE
	log10(AVG(case when (dl.direction='Downlink' and dl.TestType='DL_CE') then (power(10.0E0,dl.RSCP_avg/10.0E0)) end))*10.0 as 'RSCP_DL_CE',
	log10(AVG(case when (dl.direction='Downlink' and dl.TestType='DL_CE') then (power(10.0E0,dl.EcI0_avg/10.0E0)) end))*10.0 as 'ECIO_DL_CE',
	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_CE') then dl.[Num Codes] end) as 'CODES',
	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_CE') then dl.[% Dual Carrier] end)  as '% DC',
	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_CE') then dl.[% GSM] end) as '% GSM',
	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_CE') then dl.[% WCDMA] end) as '% WCDMA',
	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_CE') then dl.[% LTE] end) as '% LTE',

	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_CE') then dl.[% U2100] end) as '% U2100',	
	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_CE') then dl.[% U900] end) as '% U900',

	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_CE') then dl.[% QPSK 3G] end) as 'QPSK',
	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_CE') then dl.[% 16QAM 3G] end) as '16QAM',
	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_CE') then dl.[% 64QAM 3G] end) as '64QAM',
	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_CE') then 1.0*dl.[% Dual Carrier U2100] end) as '% DC 2100',
	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_CE') then 1.0*dl.[% Dual Carrier U900] end) as '% DC 900',
	log10(AVG(case when (dl.direction='Downlink' and dl.TestType='DL_CE') then (power(10.0E0,dl.UL_Interference/10.0E0)) end))*10.0 as 'UL_Inter_DL_CE',


	---- UPLINK CE
	log10(AVG(case when (ul.direction='Uplink' and ul.TestType='UL_CE') then (power(10.0E0,ul.RSCP_avg/10.0E0)) end))*10.0 as 'RSCP_UL_CE',
	log10(AVG(case when (ul.direction='Uplink' and ul.TestType='UL_CE') then (power(10.0E0,ul.EcI0_avg/10.0E0)) end))*10.0 as 'ECIO_UL_CE',
	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_CE') then ul.[% GSM] end) as '% GSM',
	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_CE') then ul.[% WCDMA] end) as '% WCDMA',
	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_CE') then ul.[% LTE] end) as '% LTE',

	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_CE') then ul.[% U2100] end) as '% U2100',	
	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_CE') then ul.[% U900] end) as '% U900',

	--'' as '%SF2',
	--'' as '%SF4',
	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_CE') then ul.[% SF22] end)/100.0 as '% SF22',
	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_CE') then ul.[% SF22andSF42] end)/100.0 as '% SF22andSF42',
	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_CE') then ul.[% SF4] end)/100.0 as '% SF4',
	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_CE') then ul.[% SF42] end)/100.0 as '% SF42',	
	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_CE') then 1.0*ul.[% TTI 2ms] end) as '% TTI 2ms',
	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_CE') then 1.0*ul.[% Dual Carrier U2100] end) as '% DC 2100',
	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_CE') then 1.0*ul.[% Dual Carrier U900] end) as '% DC 900',
	log10(AVG(case when (ul.direction='Uplink' and ul.TestType='UL_CE') then (power(10.0E0,ul.UL_Interference/10.0E0)) end))*10.0 as 'UL_Inter_UL_CE',

	---- DOWNLINK NC
	log10(AVG(case when (dl.direction='Downlink' and dl.TestType='DL_NC') then (power(10.0E0,dl.RSCP_avg/10.0E0)) end))*10.0 as 'RSCP_DL_NC',
	log10(AVG(case when (dl.direction='Downlink' and dl.TestType='DL_NC') then (power(10.0E0,dl.EcI0_avg/10.0E0)) end))*10.0 as 'ECIO_DL_NC',
	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_NC') then dl.[Num Codes] end) as 'CODES',
	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_NC') then dl.[% Dual Carrier] else null end)  as '% DC',
	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_NC') then dl.[% GSM] end) as '% GSM',
	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_NC') then dl.[% WCDMA] end) as '% WCDMA',
	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_NC') then dl.[% LTE] end) as '% LTE',

	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_NC') then dl.[% U2100] end) as '% U2100',	
	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_NC') then dl.[% U900] end) as '% U900',

	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_NC') then dl.[% QPSK 3G] end) as 'QPSK',
	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_NC') then dl.[% 16QAM 3G] end) as '16QAM',
	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_NC') then dl.[% 64QAM 3G] end) as '64QAM',
	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_NC') then 1.0*dl.[% Dual Carrier U2100] end) as '% DC 2100',
	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_NC') then 1.0*dl.[% Dual Carrier U900] end) as '% DC 900',
	log10(AVG(case when (dl.direction='Downlink' and dl.TestType='DL_NC') then (power(10.0E0,dl.UL_Interference/10.0E0)) end))*10.0 as 'UL_Inter_DL_NC',

	---- UPLINK NC
	log10(AVG(case when (ul.direction='Uplink' and ul.TestType='UL_NC') then (power(10.0E0,ul.RSCP_avg/10.0E0)) end))*10.0 as 'RSCP_UL_NC',
	log10(AVG(case when (ul.direction='Uplink' and ul.TestType='UL_NC') then (power(10.0E0,ul.EcI0_avg/10.0E0)) end))*10.0 as 'ECIO_UL_NC',
	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_NC') then ul.[% GSM] end) as '% GSM',
	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_NC') then ul.[% WCDMA] end) as '% WCDMA',
	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_NC') then ul.[% LTE] end) as '% LTE',

	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_NC') then ul.[% U2100] end) as '% U2100',	
	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_NC') then ul.[% U900] end) as '% U900',

	--'' as '%SF2',
	--'' as '%SF4',
	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_NC') then ul.[% SF22] end)/100.0 as '% SF22',
	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_NC') then ul.[% SF22andSF42] end)/100.0 as '% SF22andSF42',
	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_NC') then ul.[% SF4] end)/100.0 as '% SF4',
	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_NC') then ul.[% SF42] end)/100.0 as '% SF42',
	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_NC') then 1.0*ul.[% TTI 2ms] end) as '% TTI 2ms',
	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_NC') then 1.0*ul.[% Dual Carrier U2100] end) as '% DC 2100',
	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_NC') then 1.0*ul.[% Dual Carrier U900] end) as '% DC 900',
	log10(AVG(case when (ul.direction='Uplink' and ul.TestType='UL_NC') then (power(10.0E0,ul.UL_Interference/10.0E0)) end))*10.0 as 'UL_Inter_UL_NC'


from 
	TestInfo test,
	#All_Tests t
		LEFT OUTER JOIN Lcc_Data_HTTPTransfer_DL dl		on dl.sessionid=t.sessionid and dl.testid=t.testid
		LEFT OUTER JOIN Lcc_Data_HTTPTransfer_UL ul		on ul.sessionid=t.sessionid and ul.testid=t.testid
		LEFT OUTER JOIN Agrids.dbo.lcc_parcelas lp		on lp.Nombre= master.dbo.fn_lcc_getParcel(t.[Longitud Final], t.[Latitud Final])

where test.SessionId=t.SessionId and test.TestId=t.TestId
	and test.valid=1

	OPTION (OPTIMIZE FOR UNKNOWN)
end

else
begin
select 
	-- DOWNLINK CE
	log10(AVG(case when (dl.direction='Downlink' and dl.TestType='DL_CE') then (power(10.0E0,dl.RSCP_avg/10.0E0)) end))*10.0 as 'RSCP_DL_CE',
	log10(AVG(case when (dl.direction='Downlink' and dl.TestType='DL_CE') then (power(10.0E0,dl.EcI0_avg/10.0E0)) end))*10.0 as 'ECIO_DL_CE',
	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_CE') then dl.[Num Codes] end) as 'CODES',
	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_CE') then dl.[% Dual Carrier] end)  as '% DC',
	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_CE') then dl.[% GSM] end) as '% GSM',
	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_CE') then dl.[% WCDMA] end) as '% WCDMA',
	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_CE') then dl.[% LTE] end) as '% LTE',

	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_CE') then dl.[% U2100] end) as '% U2100',	
	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_CE') then dl.[% U900] end) as '% U900',

	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_CE') then dl.[% QPSK 3G] end) as 'QPSK',
	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_CE') then dl.[% 16QAM 3G] end) as '16QAM',
	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_CE') then dl.[% 64QAM 3G] end) as '64QAM',
	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_CE') then 1.0*dl.[% Dual Carrier U2100] end) as '% DC 2100',
	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_CE') then 1.0*dl.[% Dual Carrier U900] end) as '% DC 900',
	log10(AVG(case when (dl.direction='Downlink' and dl.TestType='DL_CE') then (power(10.0E0,dl.UL_Interference/10.0E0)) end))*10.0 as 'UL_Inter_DL_CE',


	---- UPLINK CE
	log10(AVG(case when (ul.direction='Uplink' and ul.TestType='UL_CE') then (power(10.0E0,ul.RSCP_avg/10.0E0)) end))*10.0 as 'RSCP_UL_CE',
	log10(AVG(case when (ul.direction='Uplink' and ul.TestType='UL_CE') then (power(10.0E0,ul.EcI0_avg/10.0E0)) end))*10.0 as 'ECIO_UL_CE',
	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_CE') then ul.[% GSM] end) as '% GSM',
	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_CE') then ul.[% WCDMA] end) as '% WCDMA',
	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_CE') then ul.[% LTE] end) as '% LTE',

	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_CE') then ul.[% U2100] end) as '% U2100',	
	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_CE') then ul.[% U900] end) as '% U900',

	--'' as '%SF2',
	--'' as '%SF4',
	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_CE') then ul.[% SF22] end)/100.0 as '% SF22',
	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_CE') then ul.[% SF22andSF42] end)/100.0 as '% SF22andSF42',
	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_CE') then ul.[% SF4] end)/100.0 as '% SF4',
	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_CE') then ul.[% SF42] end)/100.0 as '% SF42',	
	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_CE') then 1.0*ul.[% TTI 2ms] end) as '% TTI 2ms',
	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_CE') then 1.0*ul.[% Dual Carrier U2100] end) as '% DC 2100',
	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_CE') then 1.0*ul.[% Dual Carrier U900] end) as '% DC 900',
	log10(AVG(case when (ul.direction='Uplink' and ul.TestType='UL_CE') then (power(10.0E0,ul.UL_Interference/10.0E0)) end))*10.0 as 'UL_Inter_UL_CE',

	---- DOWNLINK NC
	log10(AVG(case when (dl.direction='Downlink' and dl.TestType='DL_NC') then (power(10.0E0,dl.RSCP_avg/10.0E0)) end))*10.0 as 'RSCP_DL_NC',
	log10(AVG(case when (dl.direction='Downlink' and dl.TestType='DL_NC') then (power(10.0E0,dl.EcI0_avg/10.0E0)) end))*10.0 as 'ECIO_DL_NC',
	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_NC') then dl.[Num Codes] end) as 'CODES',
	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_NC') then dl.[% Dual Carrier] else null end)  as '% DC',
	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_NC') then dl.[% GSM] end) as '% GSM',
	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_NC') then dl.[% WCDMA] end) as '% WCDMA',
	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_NC') then dl.[% LTE] end) as '% LTE',

	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_NC') then dl.[% U2100] end) as '% U2100',	
	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_NC') then dl.[% U900] end) as '% U900',

	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_NC') then dl.[% QPSK 3G] end) as 'QPSK',
	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_NC') then dl.[% 16QAM 3G] end) as '16QAM',
	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_NC') then dl.[% 64QAM 3G] end) as '64QAM',
	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_NC') then 1.0*dl.[% Dual Carrier U2100] end) as '% DC 2100',
	AVG(case when (dl.direction='Downlink' and dl.TestType='DL_NC') then 1.0*dl.[% Dual Carrier U900] end) as '% DC 900',
	log10(AVG(case when (dl.direction='Downlink' and dl.TestType='DL_NC') then (power(10.0E0,dl.UL_Interference/10.0E0)) end))*10.0 as 'UL_Inter_DL_NC',

	---- UPLINK NC
	log10(AVG(case when (ul.direction='Uplink' and ul.TestType='UL_NC') then (power(10.0E0,ul.RSCP_avg/10.0E0)) end))*10.0 as 'RSCP_UL_NC',
	log10(AVG(case when (ul.direction='Uplink' and ul.TestType='UL_NC') then (power(10.0E0,ul.EcI0_avg/10.0E0)) end))*10.0 as 'ECIO_UL_NC',
	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_NC') then ul.[% GSM] end) as '% GSM',
	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_NC') then ul.[% WCDMA] end) as '% WCDMA',
	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_NC') then ul.[% LTE] end) as '% LTE',

	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_NC') then ul.[% U2100] end) as '% U2100',	
	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_NC') then ul.[% U900] end) as '% U900',

	--'' as '%SF2',
	--'' as '%SF4',
	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_NC') then ul.[% SF22] end)/100.0 as '% SF22',
	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_NC') then ul.[% SF22andSF42] end)/100.0 as '% SF22andSF42',
	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_NC') then ul.[% SF4] end)/100.0 as '% SF4',
	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_NC') then ul.[% SF42] end)/100.0 as '% SF42',
	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_NC') then 1.0*ul.[% TTI 2ms] end) as '% TTI 2ms',
	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_NC') then 1.0*ul.[% Dual Carrier U2100] end) as '% DC 2100',
	AVG(case when (ul.direction='Uplink' and ul.TestType='UL_NC') then 1.0*ul.[% Dual Carrier U900] end) as '% DC 900',
	log10(AVG(case when (ul.direction='Uplink' and ul.TestType='UL_NC') then (power(10.0E0,ul.UL_Interference/10.0E0)) end))*10.0 as 'UL_Inter_UL_NC'


from 
	TestInfo test,
	Agrids.dbo.lcc_parcelas lp,
	#All_Tests t
		LEFT OUTER JOIN Lcc_Data_HTTPTransfer_DL dl		on dl.sessionid=t.sessionid and dl.testid=t.testid
		LEFT OUTER JOIN Lcc_Data_HTTPTransfer_UL ul		on ul.sessionid=t.sessionid and ul.testid=t.testid

where test.SessionId=t.SessionId and test.TestId=t.TestId
	and test.valid=1
	and lp.Nombre= master.dbo.fn_lcc_getParcel(t.[Longitud Final], t.[Latitud Final])
	and lp.entorno like @Environ

	OPTION (OPTIMIZE FOR UNKNOWN)
end		
	
drop table
#All_Tests_DL_Tech, #All_Tests_UL_Tech, #All_Tests, #All_Tests_all_Tech


