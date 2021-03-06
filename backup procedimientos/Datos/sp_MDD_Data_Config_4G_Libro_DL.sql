USE [master]
GO
/****** Object:  StoredProcedure [dbo].[sp_MDD_Data_Config_4G_Libro_DL]    Script Date: 21/12/2016 16:44:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--IF object_ID(N'[dbo].[sp_MDD_Data_Config_4G_Libro_DL]') IS NOT NULL
--              DROP PROCEDURE [dbo ].[sp_MDD_Data_Config_4G_Libro_DL]
--GO

ALTER PROCEDURE [dbo].[sp_MDD_Data_Config_4G_Libro_DL] (
	 --Variables de entrada
				@mob1 as varchar(256),
				@mob2 as varchar(256),
				@mob3 as varchar(256),
				@provincia as varchar(256),			-- si NED: '%%',	si paso1: valor
				@ciudad as varchar(256),			-- si NED: valor,	si paso1: '%%'	
				@simOperator as int,
				@sheet as varchar(256),				-- 1-all, 2-4G, 3-3G, 4-4G_Info_3G, 5-3G_Info_4G
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
--		CODIGO QUE CREA LAS PESTAÑAS CON INFO EN 4G DEL LIBRO EXTERNO DE DL:
--
--	CONFIG 4G indica la CONFIGURACION DEL EQUIPO de medida !!!
--		NO se filtra por tecnologia para poder verificar que el equipo de medida estaba debidamente forzado
--
--	Se cojen los TEST IDs correspondientes a las fechas e imeis de cada una de la tabla del HTTP Transfer DL
--
--	Solo es un select a la tabla general
--	Se linka con TestInfo para obtener solo los test validos
--
--
--	El desglose por pestañas en Config 4G, será:
--
--		@sheet = 1 - Pestaña ALL:					(info 4G)
--		-		sin filtro
--
--		@sheet = 2 - Pestaña 4G:					(info 4G)
--		--		a) 	(v.DatamodeDL_LTE >= 0.5) OR
--		--		b) 	(v.DatamodeDL_LTE < 0.5 and v.Throughput > 25 000 000 and v.DatamodeDL_GSM < v.DatamodeDL_LTE)
--
--		@sheet = 3 - Pestaña 3G:					(info 3G)		- NO SERA ESTA QUERY
--		--		a)	(v.DatamodeDL_LTE<0.5) AND 
--		--		b)	(v.Throughput<25000000 or v.Throughput is null)
--
--		@sheet = 4 - Pestaña 4G_Info_3G:			(info 3G)		- NO SERA ESTA QUERY
--		--		a)	v.DatamodeDL_LTE>=0.5 AND 
--		--		b)	v.DatamodeDL_HSDPA>0
--
--		@sheet = 5 - Pestaña 3G_Info_4G:			(info 4G)
--		--		a)	v.DatamodeDL_LTE>0 AND
--		--		b)	v.DatamodeDL_HSDPA>=0.5

-- **********************************************************************************************************************************************	

-----------------------------
----- Testing Variables -----
-----------------------------
--declare @mob1 as varchar(256) = '358672057220026'
--declare @mob2 as varchar(256) = '358672057556668'
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

--declare @fecha_ini_text1 as varchar (256) = '2015-06-17 18:00:00:000'
--declare @fecha_fin_text1 as varchar (256) = '2015-06-17 18:30:00:000'
--declare @fecha_ini_text2 as varchar (256) = '2015-06-02 23:59:59:000'
--declare @fecha_fin_text2 as varchar (256) = '2015-06-02 23:59:59:000'
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

--declare @sheet as varchar(256) = '4G'
--declare @Date as varchar(256) = '%%'

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
--	FILTROS GLOBALES	-------------------
-------------------------------------------------------------------------------		
--- DL - #All_Tests_DL
select v.sessionid, v.testid,
	case when v.[% LTE]=1 then 'LTE'
		 when v.[% WCDMA]=1 then 'WCDMA'
	else 'Mixed' end as tech,
	v.[Longitud Final], v.[Latitud Final]	
into #All_Tests_DL
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
	case when v.Testtype='DL_CE' then 'Customer Experience'
		 when v.Testtype='DL_NC' then 'Network Capability'
	else null end as TestType,
	v.ErrorType,
	v.ServiceType,
	v.[% LTE] as DatamodeDL_LTE,
	v.[% WCDMA] as DatamodeDL_HSDPA, 
	v.[% GSM] as DatamodeDL_GSM,
	v.[% U2100] as DatamodeDL_U2100,
    v.[% U900] as DatamodeDL_U900,
    v.[% LTE2600] as DatamodeDL_L2600,
    v.[% LTE2100] as DatamodeDL_L2100,
    v.[% LTE1800] as DatamodeDL_L1800,
    v.[% LTE800] as DatamodeDL_L800,
	v.[% F1 U2100],
    v.[% F2 U2100],
    v.[% F3 U2100],
    v.[% F1 U900],
    v.[% F2 U900],
	v.[% F1 L2600],
    v.[% F1 L2100],
    v.[% F2 L2100],
    v.[% F1 L1800],
    v.[% F2 L1800],
    v.[% F3 L1800],
    v.[% F1 L800],
	v.TransferTime,
	v.SessionTime,
	v.[RSRP_avg] as 'RSRP Avg',
	v.[RSRP_ini] as 'RSRP Inicial',
	v.[RSRP_Fin] as 'RSRP Final',
	v.[RSRQ_avg] as 'RSRQ Avg',
	v.[RSRQ_Ini] as 'RSRQ Inicial',
	v.[RSRQ_Fin] as 'RSRQ Final',
	v.[SINR_Avg] as 'SINR Avg',
	v.[SINR_Ini] as 'SINR Inicial',
	v.[SINR_Fin] as 'SINR Final',
	v.[% QPSK 4G]/100 as '% QPSK ',
	v.[% 16QAM 4G]/100 as '% 16QAM',
	v.[% 64QAM 4G]/100 as '% 64QAM',
	[% CA],
	v.[Shared channel use],
	v.RBs,
	v.[Max RBs],
	v.[Min RBs],
	v.[RBs When Allocated],
	v.[CQI 4G PCC] as 'CQI',
	v.[Rank Indicator PCC],
	v.[% TM Invalid],
	v.[% TM 1: Single Antenna Port 0 ],
	v.[% TM 2: TD Rank 1],
	v.[% TM 3: OL SM],
	v.[% TM 4: CL SM],
	v.[% TM 5: MU MIMO],
	v.[% TM 6: CL RANK1 PC],
	v.[% TM 7: Single Antenna Port 5],
	v.[% TM Unknown],
	v.[Longitud Inicial],
	v.[Latitud Inicial],
	v.[PCI_Ini] as 'PCI Inicial',
	v.[PCI_Fin] as 'PCI Final',
	v.[LAC/TAC_Ini] as 'TAC Inicial',
	v.[LAC/TAC_Fin] as 'TAC Final',
	v.[CellId_Ini] as 'CellID Inicial',
	v.[CellId_Fin] as 'CellID Final',
	v.[EARFCN_Ini] as 'EARFCN Inicial',
	v.[EARFCN_Fin] as 'EARFCN Final',
	v.Paging_Success_Ratio,
	v.PDP_Activate_Ratio,
	v.EARFCN_N1,
	v.PCI_N1,
	v.RSRP_N1,
	v.RSRQ_N1,
	v.num_HO_S1X2,
	v.duration_S1X2_avg,
	v.S1X2HO_SR,
	v.Max_Window_Size,
	v.IMSI,
	DB_name() as DDBB
	
into #f	
from 
	TestInfo t,
	#All_Tests_DL a,
	Lcc_Data_HTTPTransfer_DL v

where	
	a.Sessionid=t.Sessionid and a.TestId=t.TestId
	and t.valid=1
	and a.Sessionid=v.Sessionid and a.TestId=v.TestId

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
	into #finalI	
	from #f f
		LEFT OUTER JOIN	Agrids.dbo.lcc_parcelas lp on (lp.Nombre=master.dbo.fn_lcc_getParcel(f.Longitud, f.Latitud)) 


	-------------------
	-- En funcion de la pestaña que sea se filtra por %LTE y Thput:
	-- Pestaña ALL:
	if @sheet='%%'		
	begin
		select * from #finalI 
		order by FinDescarga
	end 

	-- Pestaña 4G:
	if @sheet='4G'		
	begin 
		select * from #finalI 
		where DatamodeDL_LTE >= 0.5 or 
				(DatamodeDL_LTE < 0.5 and Throughput > 25000000 and DatamodeDL_GSM < DatamodeDL_LTE)  
		order by FinDescarga
	end 

	-- Pestaña 3G_Info_4G:
	if @sheet='3G_Info_4G'	
	begin 
		select * from #finalI 
		where DatamodeDL_LTE > 0 AND
				DatamodeDL_HSDPA >= 0.5
		order by FinDescarga
	end 
	drop table #All_Tests_DL, #finalI, #f
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
	into #final	
	from #f f, 	Agrids.dbo.lcc_parcelas lp
	where lp.Nombre=master.dbo.fn_lcc_getParcel(f.Longitud, f.Latitud)
	and lp.entorno like @Environ


	-------------------
	-- En funcion de la pestaña que sea se filtra por %LTE y Thput:
	-- Pestaña ALL:
	if @sheet='%%'		
	begin
		select * from #final 
		order by FinDescarga
	end 

	-- Pestaña 4G:
	if @sheet='4G'		
	begin 
		select * from #final 
		where DatamodeDL_LTE >= 0.5 or 
				(DatamodeDL_LTE < 0.5 and Throughput > 25000000 and DatamodeDL_GSM < DatamodeDL_LTE)  
		order by FinDescarga
	end 

	-- Pestaña 3G_Info_4G:
	if @sheet='3G_Info_4G'	
	begin 
		select * from #final 
		where DatamodeDL_LTE > 0 AND
				DatamodeDL_HSDPA >= 0.5
		order by FinDescarga
	end 
	drop table #All_Tests_DL, #final, #f
end

-------------------------------------------------------------------------------
--	Borrado Tablas		-------------------	  
-------------------------------------------------------------------------------
--drop table #All_Tests_DL, #final, #f

-- select * from Lcc_Data_HTTPTransfer_DL

