USE [master]
GO
/****** Object:  StoredProcedure [dbo].[sp_MDD_Data_Config_XG_Libro_LAT]    Script Date: 21/12/2016 16:51:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--IF object_ID(N'[dbo].[sp_MDD_Data_Config_XG_Libro_LAT]') IS NOT NULL
--              DROP PROCEDURE [dbo ].[sp_MDD_Data_Config_XG_Libro_LAT]
--GO

create PROCEDURE [dbo].[sp_MDD_Data_Config_XG_Libro_LAT] (
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
--		CODIGO QUE CREA EL LIBRO EXTERNO DE LATENCIAS:
--
--	Se cojen los TEST IDs correspondientes a las fechas e imes de cada una de la tabla del HTTP Transfer Latencias
--	
--	No se indica la CONFIG (3G o 4G) porque se sacan los mismo KPIs en ambos casos
--		NO se filtra por tecnologia para poder verificar que el equipo de medida estaba debidamente forzado
--
--	Solo es un select a la tabla general
--	Se linka con TestInfo para obtener solo los test validos

--
-- Nota:	- No se incluían los niveles de señal/calidad avg/ini/finales (comentados de momento)
--
-- **********************************************************************************************************************************************	

-----------------------------
----- Testing Variables -----
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
--- Latencias - #All_Tests_LAT
select v.sessionid, v.testid, 
	case when v.[% LTE]=1 then 'LTE'
		 when v.[% WCDMA]=1 then 'WCDMA'
	else 'Mixed' end as tech,
	v.[Longitud Final], v.[Latitud Final]
into #All_Tests_LAT
from Lcc_Data_Latencias v
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
	v.CollectionName,
	'Packet Switched data call' as TipoMedidas,
	v.MCC as Pais,
	v.MNC as Operador,
	v.startDate as Fecha,
	v.startTime as InicioDescarga,
	v.endTime as FinDescarga,
	v.[Longitud Final] as Longitud,
	v.[Latitud Final] as Latitud,
	v.TypeofTest,
	v.RTT,
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
	v.[Longitud Inicial],
	v.[Latitud Inicial],
	v.Paging_Success_Ratio,
	v.PDP_Activate_Ratio,
	v.EARFCN_N1,
	v.PCI_N1,
	v.RSRP_N1,
	v.RSRQ_N1,
	v.num_HO_S1X2,
	v.duration_S1X2_avg,
	v.S1X2HO_SR,
	v.IMSI,
	DB_name() as DDBB
into #final	
	
from 
	TestInfo t,
	#All_Tests_LAT a,
	Lcc_Data_Latencias v

where	
	a.Sessionid=t.Sessionid and a.TestId=t.TestId
	and t.valid=1
	and a.Sessionid=v.Sessionid and a.TestId=v.TestId
 
 
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
		LEFT OUTER JOIN	Agrids.dbo.lcc_parcelas lp on lp.Nombre=master.dbo.fn_lcc_getParcel(f.Longitud, f.Latitud)

select * from #VI 
order by FinDescarga

drop table #All_Tests_LAT, #VI, #final

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
where lp.Nombre=master.dbo.fn_lcc_getParcel(f.Longitud, f.Latitud)
and lp.entorno like @Environ

select * from #V 
order by FinDescarga

drop table #All_Tests_LAT, #V, #final

end

-------------------------------------------------------------------------------
--	Borrado Tablas		-------------------	  
-------------------------------------------------------------------------------
--drop table #All_Tests_YTB, #V, #final


