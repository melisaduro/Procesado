
use FY1617_Data_Rest_4G_H1_2
declare @simOperator as int = 7

declare @provincia as varchar(256) = '%%'
declare @ciudad as varchar(256) = 'marin'

declare @sheet as varchar(256) = '%%'
declare @environ as varchar(256) = '%%'

declare @report as varchar(256) = 'MUN' --VDF (Reporte VDF), OSP (Reporte OSP), MUN (Municipal)

create table #All_Tests_DL_tech (
	[SessionId] bigint,
	[TestId] bigint,
	[tech] varchar (256),
	[Longitud Final] float,
	[Latitud Final] float,
	[hasCA] varchar(256)
)

create table #All_Tests_UL_tech (
	[SessionId] bigint,
	[TestId] bigint, 
	[tech] varchar (256),
	[Longitud Final] float,
	[Latitud Final] float,
	[hasCA] varchar(256)
)

create table #All_Tests_WEB_tech (
	[SessionId] bigint,
	[TestId] bigint,
	[tech] varchar (256),
	[Longitud Final] float,
	[Latitud Final] float,
	[hasCA] varchar(256)
)

create table #All_Tests_LAT_tech (
	[SessionId] bigint,
	[TestId] bigint,
	[tech] varchar (256),
	[Longitud Final] float,
	[Latitud Final] float,
	[hasCA] varchar(256)
)

create table #All_Tests_YTB_tech (
	[SessionId] bigint,
	[TestId] bigint,
	[tech] varchar (256),
	[Longitud Final] float,
	[Latitud Final] float,
	[hasCA] varchar(256)
)


-------------------------------------------------------------------------------
--	FILTROS GLOBALES:
-------------------------------------------------------------------------------		
--- DL - #All_Tests_DL

If @Report='VDF'
begin
	insert into #All_Tests_DL_Tech
	select v.sessionid, v.testid,
		case when v.[% LTE]=1 then 'LTE'
			 when v.[% WCDMA]=1 then 'WCDMA'
		else 'Mixed' end as tech,
		v.[Longitud Final], v.[Latitud Final],
		case when v.[% CA] >0 then 'CA'
		else 'SC' end as hasCA

	from Lcc_Data_HTTPTransfer_DL v, testinfo t, lcc_position_Entity_List_Vodafone c
	Where t.testid=v.testid
		and t.valid=1
		--and v.collectionname like @Date + '%' + @ciudad + '%' + @Tech and
		and v.info='completed' --DGP 17/09/2015: Filtramos solo los tests marcados como completados
		and v.MNC = @simOperator	--MNC
		and v.MCC= 214						--MCC - Descartamos los valores erróneos
		and c.fileid=v.fileid
		and c.entity_name = @Ciudad
		and c.lonid=master.dbo.fn_lcc_longitude2lonid ([Longitud Final], [Latitud Final])
		and c.latid=master.dbo.fn_lcc_latitude2latid ([Latitud Final])

	group by v.sessionid, v.testid,
		case when v.[% LTE]=1 then 'LTE'
			 when v.[% WCDMA]=1 then 'WCDMA'
		else 'Mixed' end,
		v.[Longitud Final], v.[Latitud Final],
		case when v.[% CA] >0 then 'CA'
		else 'SC' end 


	--- UL - #All_Tests_UL
	insert into #All_Tests_UL_Tech
	select v.sessionid, v.testid, 
		case when v.[% LTE]=1 then 'LTE'
			 when v.[% WCDMA]=1 then 'WCDMA'
		else 'Mixed' end as tech,
		v.[Longitud Final], v.[Latitud Final],
		'SC' hasCA

	from Lcc_Data_HTTPTransfer_UL v, lcc_position_Entity_List_Vodafone c
	Where --v.collectionname like @Date + '%' + @ciudad + '%' + @Tech and
		v.info='completed' --DGP 17/09/2015: Filtramos solo los tests marcados como completados
		and v.MNC = @simOperator	--MNC
		and v.MCC= 214						--MCC - Descartamos los valores erróneos
		and c.fileid=v.fileid
		and c.entity_name = @Ciudad
		and c.lonid=master.dbo.fn_lcc_longitude2lonid ([Longitud Final], [Latitud Final])
		and c.latid=master.dbo.fn_lcc_latitude2latid ([Latitud Final])					

	group by v.sessionid, v.testid, 
		case when v.[% LTE]=1 then 'LTE'
			 when v.[% WCDMA]=1 then 'WCDMA'
		else 'Mixed' end,
		v.[Longitud Final], v.[Latitud Final]

	     
	--- WEB - #All_Tests_WEB
	insert into #All_Tests_WEB_Tech
	select v.sessionid, v.testid, 
		case when v.[% LTE]=1 then 'LTE'
			 when v.[% WCDMA]=1 then 'WCDMA'
		else 'Mixed' end as tech,
		v.[Longitud Final], v.[Latitud Final],
		'SC' hasCA

	from Lcc_Data_HTTPBrowser v, lcc_position_Entity_List_Vodafone c
	Where --v.collectionname like @Date + '%' + @ciudad + '%' + @Tech and
		v.info='completed' --DGP 17/09/2015: Filtramos solo los tests marcados como completados
		and v.MNC = @simOperator	--MNC
		and v.MCC= 214						--MCC - Descartamos los valores erróneos
		and c.fileid=v.fileid
		and c.entity_name = @Ciudad
		and c.lonid=master.dbo.fn_lcc_longitude2lonid ([Longitud Final], [Latitud Final])
		and c.latid=master.dbo.fn_lcc_latitude2latid ([Latitud Final])

	group by v.sessionid, v.testid, 
		case when v.[% LTE]=1 then 'LTE'
			 when v.[% WCDMA]=1 then 'WCDMA'
		else 'Mixed' end,
		v.[Longitud Final], v.[Latitud Final]


	--- Youtube - #All_Tests_YTB
	insert into #All_Tests_YTB_Tech
	select v.sessionid, v.testid, 
		case when v.[% LTE]=1 then 'LTE'
			 when v.[% WCDMA]=1 then 'WCDMA'
		else 'Mixed' end as tech,
		v.[Longitud Final], v.[Latitud Final],
		'SC' hasCA

	from Lcc_Data_YOUTUBE v, lcc_position_Entity_List_Vodafone c
	Where --v.collectionname like @Date + '%' + @ciudad + '%' + @Tech and
		v.info='completed' --DGP 17/09/2015: Filtramos solo los tests marcados como completados
		and v.MNC = @simOperator	--MNC
		and v.MCC= 214						--MCC - Descartamos los valores erróneos
		and c.fileid=v.fileid
		and c.entity_name = @Ciudad
		and c.lonid=master.dbo.fn_lcc_longitude2lonid ([Longitud Final], [Latitud Final])
		and c.latid=master.dbo.fn_lcc_latitude2latid ([Latitud Final])

	group by v.sessionid, v.testid, 
		case when v.[% LTE]=1 then 'LTE'
			 when v.[% WCDMA]=1 then 'WCDMA'
		else 'Mixed' end,
		v.[Longitud Final], v.[Latitud Final]


	--- Latencias - #All_Tests_LAT
	insert into #All_Tests_LAT_Tech
	select v.sessionid, v.testid, 
		case when v.[% LTE]=1 then 'LTE'
			 when v.[% WCDMA]=1 then 'WCDMA'
		else 'Mixed' end as tech,
		v.[Longitud Final], v.[Latitud Final],
		'SC' hasCA

	from Lcc_Data_Latencias v, lcc_position_Entity_List_Vodafone c
	Where --v.collectionname like @Date + '%' + @ciudad + '%' + @Tech and
		v.info='completed' --DGP 17/09/2015: Filtramos solo los tests marcados como completados
		and v.MNC = @simOperator	--MNC
		and v.MCC= 214						--MCC - Descartamos los valores erróneos
		and c.fileid=v.fileid
		and c.entity_name = @Ciudad
		and c.lonid=master.dbo.fn_lcc_longitude2lonid ([Longitud Final], [Latitud Final])
		and c.latid=master.dbo.fn_lcc_latitude2latid ([Latitud Final])

	group by v.sessionid, v.testid, 
		case when v.[% LTE]=1 then 'LTE'
			 when v.[% WCDMA]=1 then 'WCDMA'
		else 'Mixed' end,
		v.[Longitud Final], v.[Latitud Final]
end	     

If @Report='OSP'
begin
	insert into #All_Tests_DL_Tech
	select v.sessionid, v.testid,
		case when v.[% LTE]=1 then 'LTE'
			 when v.[% WCDMA]=1 then 'WCDMA'
		else 'Mixed' end as tech,
		v.[Longitud Final], v.[Latitud Final],
		case when v.[% CA] >0 then 'CA'
		else 'SC' end as hasCA

	from Lcc_Data_HTTPTransfer_DL v, testinfo t, lcc_position_Entity_List_Orange c
	Where t.testid=v.testid
		and t.valid=1
		--and v.collectionname like @Date + '%' + @ciudad + '%' + @Tech and
		and v.info='completed' --DGP 17/09/2015: Filtramos solo los tests marcados como completados
		and v.MNC = @simOperator	--MNC
		and v.MCC= 214						--MCC - Descartamos los valores erróneos
		and c.fileid=v.fileid
		and c.entity_name = @Ciudad
		and c.lonid=master.dbo.fn_lcc_longitude2lonid ([Longitud Final], [Latitud Final])
		and c.latid=master.dbo.fn_lcc_latitude2latid ([Latitud Final])

	group by v.sessionid, v.testid,
		case when v.[% LTE]=1 then 'LTE'
			 when v.[% WCDMA]=1 then 'WCDMA'
		else 'Mixed' end,
		v.[Longitud Final], v.[Latitud Final],
		case when v.[% CA] >0 then 'CA'
		else 'SC' end 


	--- UL - #All_Tests_UL
	insert into #All_Tests_UL_Tech
	select v.sessionid, v.testid, 
		case when v.[% LTE]=1 then 'LTE'
			 when v.[% WCDMA]=1 then 'WCDMA'
		else 'Mixed' end as tech,
		v.[Longitud Final], v.[Latitud Final],
		'SC' hasCA

	from Lcc_Data_HTTPTransfer_UL v, lcc_position_Entity_List_Orange c
	Where --v.collectionname like @Date + '%' + @ciudad + '%' + @Tech and
		v.info='completed' --DGP 17/09/2015: Filtramos solo los tests marcados como completados
		and v.MNC = @simOperator	--MNC
		and v.MCC= 214						--MCC - Descartamos los valores erróneos
		and c.fileid=v.fileid
		and c.entity_name = @Ciudad
		and c.lonid=master.dbo.fn_lcc_longitude2lonid ([Longitud Final], [Latitud Final])
		and c.latid=master.dbo.fn_lcc_latitude2latid ([Latitud Final])					

	group by v.sessionid, v.testid, 
		case when v.[% LTE]=1 then 'LTE'
			 when v.[% WCDMA]=1 then 'WCDMA'
		else 'Mixed' end,
		v.[Longitud Final], v.[Latitud Final]

	     
	--- WEB - #All_Tests_WEB
	insert into #All_Tests_WEB_Tech
	select v.sessionid, v.testid, 
		case when v.[% LTE]=1 then 'LTE'
			 when v.[% WCDMA]=1 then 'WCDMA'
		else 'Mixed' end as tech,
		v.[Longitud Final], v.[Latitud Final],
		'SC' hasCA

	from Lcc_Data_HTTPBrowser v, lcc_position_Entity_List_Orange c
	Where --v.collectionname like @Date + '%' + @ciudad + '%' + @Tech and
		v.info='completed' --DGP 17/09/2015: Filtramos solo los tests marcados como completados
		and v.MNC = @simOperator	--MNC
		and v.MCC= 214						--MCC - Descartamos los valores erróneos
		and c.fileid=v.fileid
		and c.entity_name = @Ciudad
		and c.lonid=master.dbo.fn_lcc_longitude2lonid ([Longitud Final], [Latitud Final])
		and c.latid=master.dbo.fn_lcc_latitude2latid ([Latitud Final])

	group by v.sessionid, v.testid, 
		case when v.[% LTE]=1 then 'LTE'
			 when v.[% WCDMA]=1 then 'WCDMA'
		else 'Mixed' end,
		v.[Longitud Final], v.[Latitud Final]


	--- Youtube - #All_Tests_YTB
	insert into #All_Tests_YTB_Tech
	select v.sessionid, v.testid, 
		case when v.[% LTE]=1 then 'LTE'
			 when v.[% WCDMA]=1 then 'WCDMA'
		else 'Mixed' end as tech,
		v.[Longitud Final], v.[Latitud Final],
		'SC' hasCA

	from Lcc_Data_YOUTUBE v, lcc_position_Entity_List_Orange c
	Where --v.collectionname like @Date + '%' + @ciudad + '%' + @Tech and
		v.info='completed' --DGP 17/09/2015: Filtramos solo los tests marcados como completados
		and v.MNC = @simOperator	--MNC
		and v.MCC= 214						--MCC - Descartamos los valores erróneos
		and c.fileid=v.fileid
		and c.entity_name = @Ciudad
		and c.lonid=master.dbo.fn_lcc_longitude2lonid ([Longitud Final], [Latitud Final])
		and c.latid=master.dbo.fn_lcc_latitude2latid ([Latitud Final])

	group by v.sessionid, v.testid, 
		case when v.[% LTE]=1 then 'LTE'
			 when v.[% WCDMA]=1 then 'WCDMA'
		else 'Mixed' end,
		v.[Longitud Final], v.[Latitud Final]


	--- Latencias - #All_Tests_LAT
	insert into #All_Tests_LAT_Tech
	select v.sessionid, v.testid, 
		case when v.[% LTE]=1 then 'LTE'
			 when v.[% WCDMA]=1 then 'WCDMA'
		else 'Mixed' end as tech,
		v.[Longitud Final], v.[Latitud Final],
		'SC' hasCA

	from Lcc_Data_Latencias v, lcc_position_Entity_List_Orange c
	Where --v.collectionname like @Date + '%' + @ciudad + '%' + @Tech and
		v.info='completed' --DGP 17/09/2015: Filtramos solo los tests marcados como completados
		and v.MNC = @simOperator	--MNC
		and v.MCC= 214						--MCC - Descartamos los valores erróneos
		and c.fileid=v.fileid
		and c.entity_name = @Ciudad
		and c.lonid=master.dbo.fn_lcc_longitude2lonid ([Longitud Final], [Latitud Final])
		and c.latid=master.dbo.fn_lcc_latitude2latid ([Latitud Final])

	group by v.sessionid, v.testid, 
		case when v.[% LTE]=1 then 'LTE'
			 when v.[% WCDMA]=1 then 'WCDMA'
		else 'Mixed' end,
		v.[Longitud Final], v.[Latitud Final]
end	  

If @Report='MUN'
begin
	insert into #All_Tests_DL_Tech
	select v.sessionid, v.testid,
		case when v.[% LTE]=1 then 'LTE'
			 when v.[% WCDMA]=1 then 'WCDMA'
		else 'Mixed' end as tech,
		v.[Longitud Final], v.[Latitud Final],
		case when v.[% CA] >0 then 'CA'
		else 'SC' end as hasCA

	from Lcc_Data_HTTPTransfer_DL v, testinfo t, lcc_position_Entity_List_Municipio c
	Where t.testid=v.testid
		and t.valid=1
		--and v.collectionname like @Date + '%' + @ciudad + '%' + @Tech and
		and v.info='completed' --DGP 17/09/2015: Filtramos solo los tests marcados como completados
		and v.MNC = @simOperator	--MNC
		and v.MCC= 214						--MCC - Descartamos los valores erróneos
		and c.fileid=v.fileid
		and c.entity_name = @Ciudad
		and c.lonid=master.dbo.fn_lcc_longitude2lonid ([Longitud Final], [Latitud Final])
		and c.latid=master.dbo.fn_lcc_latitude2latid ([Latitud Final])

	group by v.sessionid, v.testid,
		case when v.[% LTE]=1 then 'LTE'
			 when v.[% WCDMA]=1 then 'WCDMA'
		else 'Mixed' end,
		v.[Longitud Final], v.[Latitud Final],
		case when v.[% CA] >0 then 'CA'
		else 'SC' end 

		--select * from #All_Tests_DL_Tech W, TESTINFO T WHERE W.TESTID=T.TESTID AND T.VALID=1
	--select * from #All_Tests_DL_Tech

	--- UL - #All_Tests_UL
	insert into #All_Tests_UL_Tech
	select v.sessionid, v.testid, 
		case when v.[% LTE]=1 then 'LTE'
			 when v.[% WCDMA]=1 then 'WCDMA'
		else 'Mixed' end as tech,
		v.[Longitud Final], v.[Latitud Final],
		'SC' hasCA

	from Lcc_Data_HTTPTransfer_UL v, lcc_position_Entity_List_Municipio c
	Where --v.collectionname like @Date + '%' + @ciudad + '%' + @Tech and
		v.info='completed' --DGP 17/09/2015: Filtramos solo los tests marcados como completados
		and v.MNC = @simOperator	--MNC
		and v.MCC= 214						--MCC - Descartamos los valores erróneos
		and c.fileid=v.fileid
		and c.entity_name = @Ciudad
		and c.lonid=master.dbo.fn_lcc_longitude2lonid ([Longitud Final], [Latitud Final])
		and c.latid=master.dbo.fn_lcc_latitude2latid ([Latitud Final])					

	group by v.sessionid, v.testid, 
		case when v.[% LTE]=1 then 'LTE'
			 when v.[% WCDMA]=1 then 'WCDMA'
		else 'Mixed' end,
		v.[Longitud Final], v.[Latitud Final]
	select * from #All_Tests_UL_Tech W, TESTINFO T WHERE W.TESTID=T.TESTID AND T.VALID=1
	     
	--- WEB - #All_Tests_WEB
	insert into #All_Tests_WEB_Tech
	select v.sessionid, v.testid, 
		case when v.[% LTE]=1 then 'LTE'
			 when v.[% WCDMA]=1 then 'WCDMA'
		else 'Mixed' end as tech,
		v.[Longitud Final], v.[Latitud Final],
		'SC' hasCA

	from Lcc_Data_HTTPBrowser v, lcc_position_Entity_List_Municipio c
	Where --v.collectionname like @Date + '%' + @ciudad + '%' + @Tech and
		v.info='completed' --DGP 17/09/2015: Filtramos solo los tests marcados como completados
		and v.MNC = @simOperator	--MNC
		and v.MCC= 214						--MCC - Descartamos los valores erróneos
		and c.fileid=v.fileid
		and c.entity_name = @Ciudad
		and c.lonid=master.dbo.fn_lcc_longitude2lonid ([Longitud Final], [Latitud Final])
		and c.latid=master.dbo.fn_lcc_latitude2latid ([Latitud Final])

	group by v.sessionid, v.testid, 
		case when v.[% LTE]=1 then 'LTE'
			 when v.[% WCDMA]=1 then 'WCDMA'
		else 'Mixed' end,
		v.[Longitud Final], v.[Latitud Final]

	--select * from #All_Tests_WEB_Tech W, TESTINFO T WHERE W.TESTID=T.TESTID AND T.VALID=1

	--- Youtube - #All_Tests_YTB
	insert into #All_Tests_YTB_Tech
	select v.sessionid, v.testid, 
		case when v.[% LTE]=1 then 'LTE'
			 when v.[% WCDMA]=1 then 'WCDMA'
		else 'Mixed' end as tech,
		v.[Longitud Final], v.[Latitud Final],
		'SC' hasCA

	from Lcc_Data_YOUTUBE v, lcc_position_Entity_List_Municipio c
	Where --v.collectionname like @Date + '%' + @ciudad + '%' + @Tech and
		v.info='completed' --DGP 17/09/2015: Filtramos solo los tests marcados como completados
		and v.MNC = @simOperator	--MNC
		and v.MCC= 214						--MCC - Descartamos los valores erróneos
		and c.fileid=v.fileid
		and c.entity_name = @Ciudad
		and c.lonid=master.dbo.fn_lcc_longitude2lonid ([Longitud Final], [Latitud Final])
		and c.latid=master.dbo.fn_lcc_latitude2latid ([Latitud Final])

	group by v.sessionid, v.testid, 
		case when v.[% LTE]=1 then 'LTE'
			 when v.[% WCDMA]=1 then 'WCDMA'
		else 'Mixed' end,
		v.[Longitud Final], v.[Latitud Final]


	--- Latencias - #All_Tests_LAT
	insert into #All_Tests_LAT_Tech
	select v.sessionid, v.testid, 
		case when v.[% LTE]=1 then 'LTE'
			 when v.[% WCDMA]=1 then 'WCDMA'
		else 'Mixed' end as tech,
		v.[Longitud Final], v.[Latitud Final],
		'SC' hasCA

	from Lcc_Data_Latencias v, lcc_position_Entity_List_Municipio c
	Where --v.collectionname like @Date + '%' + @ciudad + '%' + @Tech and
		v.info='completed' --DGP 17/09/2015: Filtramos solo los tests marcados como completados
		and v.MNC = @simOperator	--MNC
		and v.MCC= 214						--MCC - Descartamos los valores erróneos
		and c.fileid=v.fileid
		and c.entity_name = @Ciudad
		and c.lonid=master.dbo.fn_lcc_longitude2lonid ([Longitud Final], [Latitud Final])
		and c.latid=master.dbo.fn_lcc_latitude2latid ([Latitud Final])

	group by v.sessionid, v.testid, 
		case when v.[% LTE]=1 then 'LTE'
			 when v.[% WCDMA]=1 then 'WCDMA'
		else 'Mixed' end,
		v.[Longitud Final], v.[Latitud Final]
end	  
	     	     
-- Juntamos todos los id:
select * into #All_Tests_all_Tech from #All_Tests_DL_Tech union all
select * from #All_Tests_UL_Tech union all
select * from #All_Tests_WEB_Tech union all 
select * from #All_Tests_YTB_Tech union all 
select * from #All_Tests_LAT_Tech


-- En funcion de la pestaña que sea, se filtra por la tecnologia de interes
--	declare @sheet as varchar(256) = 'LTE'

--DGP 16/09/2015: Cambiamos el procesado para sacar el procesado para CA only
--------------------------------------------------------------------------------
declare @sheet1 as varchar(255)
declare @CA as varchar(255)

If @sheet = 'CA'
begin
	set @sheet1 = 'LTE'
	set @CA='%CA%'
end
else 
begin
	set @sheet1 = @sheet
	set @CA='%%'
end
-------------------------------------------------------------------------------
select * into #All_Tests from #All_Tests_all_Tech where tech like @sheet1
select * into #All_Tests_LAT from #All_Tests_LAT_Tech where tech like @sheet1


-------------------------------------------------------------------------------
-- PERCENTILES THROUGHPUT:
-- DGP: 03/02/2016 Se hace la distinción por indoor y no indoor para que geolocalice y catalogue bien.
-------------------------------------------------------------------------------

declare @THresult float
declare @umbral float
declare @umbralUL float

if (db_name() like '%3G%' or @sheet='WCDMA')
	begin
		set @umbral=1000
		set @umbralUL=500
	end
else
	begin
		set @umbral=5000
		set @umbralUL=2500
	end

if (db_name() like '%Indoor%' or db_name() like '%AVE%')
	begin

		create table #TH_perc_Indoor ([value] float null)		
		create table #TH_PCT_DL_CE_Pct10_Indoor ([Thput10] float null)
		create table #TH_PCT_DL_NC_Pct10_Indoor ([Thput10] float null)
		create table #TH_PCT_UL_CE_Pct10_Indoor ([Thput10] float null)
		create table #TH_PCT_UL_NC_Pct10_Indoor ([Thput10] float null)
		create table #TH_PCT_DL_CE_Pct90_Indoor ([Thput90] float null)
		create table #TH_PCT_DL_NC_Pct90_Indoor ([Thput90] float null)
		create table #TH_PCT_UL_CE_Pct90_Indoor ([Thput90] float null)
		create table #TH_PCT_UL_NC_Pct90_Indoor ([Thput90] float null)
		create table #TH_PCT_DL_CE_STDEV_Indoor ([Thput] float null)
		create table #TH_PCT_DL_NC_STDEV_Indoor ([Thput] float null)
		create table #TH_PCT_UL_CE_STDEV_Indoor ([Thput] float null)
		create table #TH_PCT_UL_NC_STDEV_Indoor ([Thput] float null)

		--  Percentiles DL:
		select 
			t.sessionid, t.testid, testType, -- de momento no hay testtype
			t.Throughput,
			ROW_NUMBER() OVER (partition by t.typeoftest order by t.Throughput) as id
		into #TH_PCT_DL_Indoor
		from Lcc_Data_HTTPTransfer_DL t, #All_Tests a, testinfo test
		where t.sessionid=a.sessionid and t.testid=a.testid 
			and test.sessionid=t.sessionid and test.testid=t.testid and test.valid=1
			and ISNULL(t.Throughput,0) > 0
			-- DGP 16/09/2015: Si estamos en la hoja CA solo sacamos los resultados con Carrier Aggregation
			and a.hasCA like @CA
		
		-- DL_CE_10:
		insert into #TH_perc_Indoor
		select  Throughput as  Thput_pct
				from #TH_PCT_DL_Indoor
				where testtype = 'DL_CE'
				and Throughput is not null
				
		exec sp_lcc_Percentil 10, @umbral, '#TH_perc_Indoor', @THresult output

		insert into #TH_PCT_DL_CE_Pct10_Indoor
		select @THresult

		set @THresult= null
		
		delete from #TH_perc_Indoor

		-- DL_CE_90:
		insert into #TH_perc_Indoor
		select  Throughput as  Thput_pct
				from #TH_PCT_DL_Indoor
				where testtype = 'DL_CE'
				and Throughput is not null
				
		exec sp_lcc_Percentil 90, @umbral, '#TH_perc_Indoor', @THresult output

		insert into #TH_PCT_DL_CE_Pct90_Indoor
		select @THresult

		set @THresult= null
		
		delete from #TH_perc_Indoor

		-- DL_NC_10:
		insert into #TH_perc_Indoor
		select  Throughput as  Thput_pct
				from #TH_PCT_DL_Indoor
				where testtype = 'DL_NC'
				and Throughput is not null
				
		exec sp_lcc_Percentil 10, @umbral, '#TH_perc_Indoor', @THresult output

		insert into #TH_PCT_DL_NC_Pct10_Indoor
		select @THresult

		set @THresult= null
		
		delete from #TH_perc_Indoor

		-- DL_NC_90:
		insert into #TH_perc_Indoor
		select  Throughput as  Thput_pct
				from #TH_PCT_DL_Indoor
				where testtype = 'DL_NC'
				and Throughput is not null
				
		exec sp_lcc_Percentil 90, @umbral, '#TH_perc_Indoor', @THresult output

		insert into #TH_PCT_DL_NC_Pct90_Indoor
		select @THresult

		set @THresult= null
		
		delete from #TH_perc_Indoor

		-- DL_CE_STDEVP:
		insert into #TH_perc_Indoor
		select  Throughput as  Thput_pct
				from #TH_PCT_DL_Indoor
				where testtype = 'DL_CE'
				and Throughput is not null
				
		exec sp_lcc_STDEVP @umbral, '#TH_perc_Indoor', @THresult output

		insert into #TH_PCT_DL_CE_STDEV_Indoor
		select @THresult

		set @THresult= null
		
		delete from #TH_perc_Indoor

		-- DL_NC_STDEVP:
		insert into #TH_perc_Indoor
		select  Throughput as  Thput_pct
				from #TH_PCT_DL_Indoor
				where testtype = 'DL_NC'
				and Throughput is not null
				
		exec sp_lcc_STDEVP @umbral, '#TH_perc_Indoor', @THresult output

		insert into #TH_PCT_DL_NC_STDEV_Indoor
		select @THresult

		set @THresult= null
		
		delete from #TH_perc_Indoor
	
	
		--  Percentiles UL:
		select 
			t.sessionid, t.testid, testType, -- de momento no hay testtype
			t.Throughput,
			ROW_NUMBER() OVER (partition by t.typeoftest order by t.Throughput) as id
		into #TH_PCT_UL_Indoor 
		from  Lcc_Data_HTTPTransfer_UL t, #All_Tests a, testinfo test
		where t.sessionid=a.sessionid and t.testid=a.testid
			and test.sessionid=t.sessionid and test.testid=t.testid  and test.valid=1
			and ISNULL(t.Throughput,0) > 0 
			-- DGP 16/09/2015: Si estamos en la hoja CA solo sacamos los resultados con Carrier Aggregation
			and a.hasCA like @CA
	
		-- UL_CE_10:
		insert into #TH_perc_Indoor
		select  Throughput as  Thput_pct
				from #TH_PCT_UL_Indoor
				where testtype = 'UL_CE'
				and Throughput is not null
				
		exec sp_lcc_Percentil 10, @umbralUL, '#TH_perc_Indoor', @THresult output

		insert into #TH_PCT_UL_CE_Pct10_Indoor
		select @THresult

		set @THresult= null
		
		delete from #TH_perc_Indoor

		-- UL_CE_90:
		insert into #TH_perc_Indoor
		select  Throughput as  Thput_pct
				from #TH_PCT_UL_Indoor
				where testtype = 'UL_CE'
				and Throughput is not null
				
		exec sp_lcc_Percentil 90, @umbralUL, '#TH_perc_Indoor', @THresult output

		insert into #TH_PCT_UL_CE_Pct90_Indoor
		select @THresult

		set @THresult= null
		
		delete from #TH_perc_Indoor

		-- UL_NC_10:
		insert into #TH_perc_Indoor
		select  Throughput as  Thput_pct
				from #TH_PCT_UL_Indoor
				where testtype = 'UL_NC'
				and Throughput is not null
				
		exec sp_lcc_Percentil 10, @umbralUL, '#TH_perc_Indoor', @THresult output

		insert into #TH_PCT_UL_NC_Pct10_Indoor
		select @THresult

		set @THresult= null
		
		delete from #TH_perc_Indoor

		-- UL_NC_90:
		insert into #TH_perc_Indoor
		select  Throughput as  Thput_pct
				from #TH_PCT_UL_Indoor
				where testtype = 'UL_NC'
				and Throughput is not null
				
		exec sp_lcc_Percentil 90, @umbralUL, '#TH_perc_Indoor', @THresult output

		insert into #TH_PCT_UL_NC_Pct90_Indoor
		select @THresult

		set @THresult= null
		
		delete from #TH_perc_Indoor

		-- UL_CE_STDEVP:
		insert into #TH_perc_Indoor
		select  Throughput as  Thput_pct
				from #TH_PCT_UL_Indoor
				where testtype = 'UL_CE'
				and Throughput is not null
				
		exec sp_lcc_STDEVP @umbralUL, '#TH_perc_Indoor', @THresult output

		insert into #TH_PCT_UL_CE_STDEV_Indoor
		select @THresult

		set @THresult= null
		
		delete from #TH_perc_Indoor

		-- UL_NC_STDEVP:
		insert into #TH_perc_Indoor
		select  Throughput as  Thput_pct
				from #TH_PCT_UL_Indoor
				where testtype = 'UL_NC'
				and Throughput is not null
				
		exec sp_lcc_STDEVP @umbralUL, '#TH_perc_Indoor', @THresult output

		insert into #TH_PCT_UL_NC_STDEV_Indoor
		select @THresult

		set @THresult= null
		
		delete from #TH_perc_Indoor


	end

else

	begin
		create table #TH_perc ([value] float null)		
		create table #TH_PCT_DL_CE_Pct10 ([Thput10] float null)
		create table #TH_PCT_DL_NC_Pct10 ([Thput10] float null)
		create table #TH_PCT_UL_CE_Pct10 ([Thput10] float null)
		create table #TH_PCT_UL_NC_Pct10 ([Thput10] float null)
		create table #TH_PCT_DL_CE_Pct90 ([Thput90] float null)
		create table #TH_PCT_DL_NC_Pct90 ([Thput90] float null)
		create table #TH_PCT_UL_CE_Pct90 ([Thput90] float null)
		create table #TH_PCT_UL_NC_Pct90 ([Thput90] float null)
		create table #TH_PCT_DL_CE_STDEV ([Thput] float null)
		create table #TH_PCT_DL_NC_STDEV ([Thput] float null)
		create table #TH_PCT_UL_CE_STDEV ([Thput] float null)
		create table #TH_PCT_UL_NC_STDEV ([Thput] float null)

		--  Percentiles DL
		select 
			t.sessionid, t.testid, testType, -- de momento no hay testtype
			t.Throughput,
			ROW_NUMBER() OVER (partition by t.typeoftest order by t.Throughput) as id
		into #TH_PCT_DL
		from Lcc_Data_HTTPTransfer_DL t, #All_Tests a, testinfo test, agrids.dbo.lcc_parcelas lp
		where t.sessionid=a.sessionid and t.testid=a.testid 
			and test.sessionid=t.sessionid and test.testid=t.testid and test.valid=1
			and ISNULL(t.Throughput,0) > 0
			
			-- DGP 16/09/2015: Si estamos en la hoja CA solo sacamos los resultados con Carrier Aggregation
			and a.hasCA like @CA
			and lp.Nombre= master.dbo.fn_lcc_getParcel(t.[Longitud Final], t.[Latitud Final])
			and lp.entorno like @Environ 

		
		-- DL_CE_10:
		insert into #TH_perc
		select  Throughput as  Thput_pct
				from #TH_PCT_DL
				where testtype = 'DL_CE'
				and Throughput is not null
				
		exec sp_lcc_Percentil 10, @umbral, '#TH_perc', @THresult output

		insert into #TH_PCT_DL_CE_Pct10
		select @THresult

		set @THresult= null
		
		delete from #TH_perc

		-- DL_CE_90:
		insert into #TH_perc
		select  Throughput as  Thput_pct
				from #TH_PCT_DL
				where testtype = 'DL_CE'
				and Throughput is not null
				
		exec sp_lcc_Percentil 90, @umbral, '#TH_perc', @THresult output

		insert into #TH_PCT_DL_CE_Pct90
		select @THresult

		set @THresult= null
		
		delete from #TH_perc

		-- DL_NC_10:
		insert into #TH_perc
		select  Throughput as  Thput_pct
				from #TH_PCT_DL
				where testtype = 'DL_NC'
				and Throughput is not null
				
		exec sp_lcc_Percentil 10, @umbral, '#TH_perc', @THresult output

		insert into #TH_PCT_DL_NC_Pct10
		select @THresult

		set @THresult= null
		
		delete from #TH_perc

		-- DL_NC_90:
		insert into #TH_perc
		select  Throughput as  Thput_pct
				from #TH_PCT_DL
				where testtype = 'DL_NC'
				and Throughput is not null
				
		exec sp_lcc_Percentil 90, @umbral, '#TH_perc', @THresult output

		insert into #TH_PCT_DL_NC_Pct90
		select @THresult

		set @THresult= null
		
		delete from #TH_perc

		-- DL_CE_STDEVP:
		insert into #TH_perc
		select  Throughput as  Thput_pct
				from #TH_PCT_DL
				where testtype = 'DL_CE'
				and Throughput is not null
				
		exec sp_lcc_STDEVP @umbral, '#TH_perc', @THresult output

		insert into #TH_PCT_DL_CE_STDEV
		select @THresult

		set @THresult= null
		
		delete from #TH_perc

		-- DL_NC_STDEVP:
		insert into #TH_perc
		select  Throughput as  Thput_pct
				from #TH_PCT_DL
				where testtype = 'DL_NC'
				and Throughput is not null
				
		exec sp_lcc_STDEVP @umbral, '#TH_perc', @THresult output

		insert into #TH_PCT_DL_NC_STDEV
		select @THresult

		set @THresult= null
		
		delete from #TH_perc
	
		--  Percentiles UL:
		select 
			t.sessionid, t.testid, testType, -- de momento no hay testtype
			t.Throughput,
			ROW_NUMBER() OVER (partition by t.typeoftest order by t.Throughput) as id
		into #TH_PCT_UL
		from  Lcc_Data_HTTPTransfer_UL t, #All_Tests a, testinfo test, agrids.dbo.lcc_parcelas lp
		where t.sessionid=a.sessionid and t.testid=a.testid
			and test.sessionid=t.sessionid and test.testid=t.testid  and test.valid=1
			and ISNULL(t.Throughput,0) > 0 
			
			-- DGP 16/09/2015: Si estamos en la hoja CA solo sacamos los resultados con Carrier Aggregation
			and a.hasCA like @CA
			and lp.Nombre= master.dbo.fn_lcc_getParcel(t.[Longitud Final], t.[Latitud Final])
			and lp.entorno like @Environ 
	
		-- UL_CE_10:
		insert into #TH_perc
		select  Throughput as  Thput_pct
				from #TH_PCT_UL
				where testtype = 'UL_CE'
				and Throughput is not null
				
		exec sp_lcc_Percentil 10, @umbralUL, '#TH_perc', @THresult output

		insert into #TH_PCT_UL_CE_Pct10
		select @THresult

		set @THresult= null
		
		delete from #TH_perc

		-- UL_CE_90:
		insert into #TH_perc
		select  Throughput as  Thput_pct
				from #TH_PCT_UL
				where testtype = 'UL_CE'
				and Throughput is not null
				
		exec sp_lcc_Percentil 90, @umbralUL, '#TH_perc', @THresult output

		insert into #TH_PCT_UL_CE_Pct90
		select @THresult

		set @THresult= null
		
		delete from #TH_perc

		-- UL_NC_10:
		insert into #TH_perc
		select  Throughput as  Thput_pct
				from #TH_PCT_UL
				where testtype = 'UL_NC'
				and Throughput is not null
				
		exec sp_lcc_Percentil 10, @umbralUL, '#TH_perc', @THresult output

		insert into #TH_PCT_UL_NC_Pct10
		select @THresult

		set @THresult= null
		
		delete from #TH_perc

		-- UL_NC_90:
		insert into #TH_perc
		select  Throughput as  Thput_pct
				from #TH_PCT_UL
				where testtype = 'UL_NC'
				and Throughput is not null
				
		exec sp_lcc_Percentil 90, @umbralUL, '#TH_perc', @THresult output

		insert into #TH_PCT_UL_NC_Pct90
		select @THresult

		set @THresult= null
		
		delete from #TH_perc

		-- UL_CE_STDEVP:
		insert into #TH_perc
		select  Throughput as  Thput_pct
				from #TH_PCT_UL
				where testtype = 'UL_CE'
				and Throughput is not null
				
		exec sp_lcc_STDEVP @umbralUL, '#TH_perc', @THresult output

		insert into #TH_PCT_UL_CE_STDEV
		select @THresult

		set @THresult= null
		
		delete from #TH_perc

		-- UL_NC_STDEVP:
		insert into #TH_perc
		select  Throughput as  Thput_pct
				from #TH_PCT_UL
				where testtype = 'UL_NC'
				and Throughput is not null
				
		exec sp_lcc_STDEVP @umbralUL, '#TH_perc', @THresult output

		insert into #TH_PCT_UL_NC_STDEV
		select @THresult

		set @THresult= null
		
		delete from #TH_perc

	end

-------------------------------------------------------------------------------
-- LATENCIAS:	
--		Se podria crear aquí la tabla final asociada a la entidad, pasada como parametro?
-- DGP: 03/02/2016 Se hace la distinción por indoor y no indoor para que geolocalice y catalogue bien.
-------------------------------------------------------------------------------
declare @Pingresult float

if (db_name() like '%Indoor%' or db_name() like '%AVE%')
begin

	create table #Ping_perc_Indoor ([value] float null)		
	create table #Ping_median_Indoor ([Latency Median] float null)

select 
		COUNT(t.testid) as 'pings',
		AVG(d.rtt) as 'AVG PING'
		into #Ping_indoor
	from 
		#All_Tests_LAT t,
		Lcc_Data_Latencias d, testinfo test
	 where 
		t.SessionId=d.SessionId and t.TestId=d.TestId
			and test.sessionid=t.sessionid and test.testid=t.testid  and test.valid=1
			-- DGP 16/09/2015: Si estamos en la hoja CA solo sacamos los resultados con Carrier Aggregation
			and t.hasCA like @CA

	
	-- MEDIANA
	insert into #Ping_perc_Indoor
	select dd.RTT
		 from 
			#All_Tests_LAT t, Lcc_Data_Latencias dd, testinfo test	
					
		where 
			dd.sessionid=t.sessionid and dd.TestId=t.TestId	
				and test.sessionid=t.sessionid and test.testid=t.testid  and test.valid=1
				-- DGP 16/09/2015: Si estamos en la hoja CA solo sacamos los resultados con Carrier Aggregation
				and t.hasCA like @CA
				and dd.rtt is not null
				
		exec sp_lcc_Percentil 50, 5, '#Ping_perc_Indoor', @Pingresult output

		insert into #Ping_median_Indoor
		select @Pingresult

		set @Pingresult= null
		
		delete from #Ping_perc_Indoor

end

else

begin

	create table #Ping_perc ([value] float null)		
	create table #Ping_median ([Latency Median] float null)

select 
		COUNT(t.testid) as 'pings',
		AVG(d.rtt) as 'AVG PING'
	into #Ping
	from 
		#All_Tests_LAT t,
		Lcc_Data_Latencias d, testinfo test, agrids.dbo.lcc_parcelas lp
	 where 
		t.SessionId=d.SessionId and t.TestId=d.TestId
			and test.sessionid=t.sessionid and test.testid=t.testid  and test.valid=1
			-- DGP 16/09/2015: Si estamos en la hoja CA solo sacamos los resultados con Carrier Aggregation
			and t.hasCA like @CA
			and lp.Nombre= master.dbo.fn_lcc_getParcel(d.[Longitud Final], d.[Latitud Final])
			and lp.entorno like @Environ 

	
	-- MEDIANA
	insert into #Ping_perc
	select dd.RTT
		 from 
			#All_Tests_LAT t, Lcc_Data_Latencias dd, testinfo test, agrids.dbo.lcc_parcelas lp				
		where 
			dd.sessionid=t.sessionid and dd.TestId=t.TestId	
				and test.sessionid=t.sessionid and test.testid=t.testid  and test.valid=1
				-- DGP 16/09/2015: Si estamos en la hoja CA solo sacamos los resultados con Carrier Aggregation
				and t.hasCA like @CA
				and lp.Nombre= master.dbo.fn_lcc_getParcel(dd.[Longitud Final], dd.[Latitud Final])
				and lp.entorno like @Environ 

		exec sp_lcc_Percentil 50, 5, '#Ping_perc', @Pingresult output

		insert into #Ping_median
		select @Pingresult

		set @Pingresult= null
		
		delete from #Ping_perc


end

------------------------------------------------------------------------------------
------------------------------- SELECT GENERAL
---------------- All Sheet for KPI dATA Aggregated Info Book
-- DGP 23/11/2015: Se le aplica el filtro por GPS a las medidas de BenchMarker
------------------------------------------------------------------------------------

if (db_name() like '%Indoor%' or db_name() like '%AVE%')
begin
select 
-----------
-- DL CE:
SUM(case when (dl.direction='Downlink' and dl.TestType='DL_CE') then 1 else 0 end) as 'DOWNLINK - NUMBER OF ATTEMPTS [N]',
SUM(case when (dl.direction='Downlink' and dl.TestType='DL_CE' and dl.ErrorType='Accessibility') then 1 else 0 end) as 'DOWNLINK - NUMBER OF ERRORS IN ACCESSIBILITY [N]',
SUM(case when (dl.direction='Downlink' and dl.TestType='DL_CE' and dl.ErrorType='Retainability') then 1 else 0 end) as 'DOWNLINK - NUMBER OF ERRORS IN RETAINABILITY [N]',

AVG(case when (dl.direction='Downlink' and dl.TestType='DL_CE' and ISNULL(dl.Throughput,0)>0) then dl.Throughput end) as 'DOWNLINK - D1.DOWNLOAD SPEED [KBIT/S] AVG',

(select Thput from #TH_PCT_DL_CE_STDEV_Indoor) as 'DOWNLINK - THROUGHPUT STANDARD DEVIATION',
--STDEV(case when (dl.direction='Downlink' and dl.TestType='DL_CE' and ISNULL(dl.Throughput,0)>0) then dl.Throughput end) as 'DOWNLINK - THROUGHPUT STANDARD DEVIATION',

case when (SUM (case when (dl.direction='Downlink' and dl.TestType='DL_CE' and ISNULL(dl.Throughput,0)>0) then 1 else 0 end)) = 0 then 0 
	else (1.0*SUM(case when (dl.direction='Downlink' and dl.TestType='DL_CE' and ISNULL(dl.Throughput,0)>3000) then 1 else 0 end)
		/SUM (case when (dl.direction='Downlink' and dl.TestType='DL_CE' and ISNULL(dl.Throughput,0)>0) then 1 else 0 end)) end as 'DOWNLINK - D2. PERCENTAGE OF DL CONNECTIONS WITH THROUGHPUT > 3 MBPS',
		
SUM(case when (dl.direction='Downlink' and dl.TestType='DL_CE' and ISNULL(dl.Throughput,0)>3000) then 1 else 0 end)  as 'DOWNLINK - NUMBER OF DL WITH TROUGHPUT > 3 MBPS',
SUM(case when (dl.direction='Downlink' and dl.TestType='DL_CE' and ISNULL(dl.Throughput,0)>1000) then 1 else 0 end)  as 'DOWNLINK - NUMBER OF DL WITH THROUGHPUT > 1 MBPS',
MAX(case when (dl.direction='Downlink' and dl.TestType='DL_CE' and ISNULL(dl.Throughput,0)>0) then dl.Throughput end) as 'DOWNLINK - PEAK DATA USER RATE [KBIT/S]',

(select Thput10 from #TH_PCT_DL_CE_Pct10_Indoor)	as 'DOWNLINK - 10TH PERCENTILE THR',
 
null as 'DOWNLINK - 10TH THR. (CALCULATED ON ALL MAIN CITIES AGGREGATION ) ',
null as 'DOWNLINK - 10TH THR. (CALCULATED ON ALL MAIN AND SMALLER CITIES AGGREGATION)',

(select Thput90 from #TH_PCT_DL_CE_Pct90_Indoor) as 'DOWNLINK - 90TH PERCENTILE THR',
 
null as 'DOWNLINK - 90TH THR. (CALCULATED ON ALL MAIN CITIES AGGREGATION ) ',
null as 'DOWNLINK - 90TH THR. (CALCULATED ON ALL MAIN AND SMALLER CITIES AGGREGATION)',


-----------
-- UL CE:
SUM(case when (ul.direction='Uplink' and ul.TestType='UL_CE') then 1 else 0 end) as 'UPLINK - NUMBER OF ATTEMPTS [N]',
SUM(case when (ul.direction='Uplink' and ul.TestType='UL_CE' and ul.ErrorType='Accessibility') then 1 else 0 end) as 'UPLINK - NUMBER OF ERRORS IN ACCESSIBILITY [N]',
SUM(case when (ul.direction='Uplink' and ul.TestType='UL_CE' and ul.ErrorType='Retainability') then 1 else 0 end) as 'UPLINK - NUMBER OF ERRORS IN RETAINABILITY [N]',

AVG(case when (ul.direction='Uplink' and ul.TestType='UL_CE' and ISNULL(ul.Throughput,0)>0) then ul.Throughput end) as 'UPLINK - D3.UPLOAD SPEED [KBIT/S] AVG',
(select Thput from #TH_PCT_UL_CE_STDEV_Indoor) as 'UPLINK - THROUGHPUT STANDARD DEVIATION',
--STDEV(case when (ul.direction='Uplink' and ul.TestType='UL_CE' and ISNULL(ul.Throughput,0)>0) then ul.Throughput end) as 'UPLINK - THROUGHPUT STANDARD DEVIATION',
MAX(case when (ul.direction='Uplink' and ul.TestType='UL_CE' and ISNULL(ul.Throughput,0)>0) then ul.Throughput end) as 'UPLINK - PEAK DATA USER RATE [KBIT/S]',

(select Thput10 from #TH_PCT_UL_CE_Pct10_Indoor) as 'UPLINK - 10TH PERCENTILE THR',
 
null as 'UPLINK - 10TH THR. (CALCULATED ON ALL MAIN CITIES AGGREGATION )',
null as 'UPLINK - 10TH THR. (CALCULATED ON ALL MAIN AND SMALLER CITIES AGGREGATION)',

(select Thput90 from #TH_PCT_UL_CE_Pct90_Indoor) as 'UPLINK - 90TH PERCENTILE THR',
 
null as 'UPLINK - 90TH THR. (CALCULATED ON ALL MAIN CITIES AGGREGATION ) ',
null as 'UPLINK - 90TH THR. (CALCULATED ON ALL MAIN AND SMALLER CITIES AGGREGATION)',

-----------
-- DL NC:
SUM(case when (dl.direction='Downlink' and dl.TestType='DL_NC') then 1 else 0 end) as 'DOWNLINK NETWORK CAPABILITY - NUMBER OF ATTEMPTS [N]',
SUM(case when (dl.direction='Downlink' and dl.TestType='DL_NC' and dl.ErrorType='Accessibility') then 1 else 0 end) as 'DOWNLINK NETWORK CAPABILITY - NUMBER OF ERRORS IN ACCESSIBILITY [N]',
SUM(case when (dl.direction='Downlink' and dl.TestType='DL_NC' and dl.ErrorType='Retainability') then 1 else 0 end) as 'DOWNLINK NETWORK CAPABILITY - NUMBER OF ERRORS IN RETAINABILITY [N]',

SUM(case when (dl.direction='Downlink' and dl.TestType='DL_NC' and ISNULL(dl.Throughput,0)>128) then 1 else 0 end) as 'DOWNLINK NETWORK CAPABILITY - NUMBERS OF SESSIONS WHOSE THROUGHPUT EXCEEDS 128 Kbps',

AVG(case when (dl.direction='Downlink' and dl.TestType='DL_NC' and ISNULL(dl.Throughput,0)>0) then dl.Throughput end) as 'DOWNLINK NETWORK CAPABILITY - MEAN DATA USER RATE [KBIT/S]',
(select Thput from #TH_PCT_DL_NC_STDEV_Indoor) as 'DOWNLINK NETWORK CAPABILITY - THROUGHPUT STANDARD DEVIATION',
--STDEV(case when (dl.direction='Downlink' and dl.TestType='DL_NC' and ISNULL(dl.Throughput,0)>0) then dl.Throughput end) as 'DOWNLINK NETWORK CAPABILITY - THROUGHPUT STANDARD DEVIATION',
MAX(case when (dl.direction='Downlink' and dl.TestType='DL_NC' and ISNULL(dl.Throughput,0)>0) then dl.Throughput end) as 'DOWNLINK NETWORK CAPABILITY - PEAK DATA USER RATE [KBIT/S]',

(select Thput10 from #TH_PCT_DL_NC_Pct10_Indoor) as 'DOWNLINK NETWORK CAPABILITY - 10TH PERCENTILE THR',
 
null as 'DOWNLINK NETWORK CAPABILITY - 10TH THR. (CALCULATED ON ALL MAIN CITIES AGGREGATION ) ',
null as 'DOWNLINK NETWORK CAPABILITY - 10TH THR. (CALCULATED ON ALL MAIN AND SMALLER CITIES AGGREGATION)',

(select Thput90 from #TH_PCT_DL_NC_Pct90_Indoor) as 'DOWNLINK NETWORK CAPABILITY - 90TH PERCENTILE THR',

null as 'DOWNLINK NETWORK CAPABILITY - 90TH THR. (CALCULATED ON ALL MAIN CITIES AGGREGATION ) ',
null as 'DOWNLINK NETWORK CAPABILITY - 90TH THR. (CALCULATED ON ALL MAIN AND SMALLER CITIES AGGREGATION)',

-----------
-- UL NC:
SUM(case when (ul.direction='Uplink' and ul.TestType='UL_NC') then 1 else 0 end) as 'UPLINK NETWORK CAPABILITY - NUMBER OF ATTEMPTS [N]',
SUM(case when (ul.direction='Uplink' and ul.TestType='UL_NC' and ul.ErrorType='Accessibility') then 1 else 0 end) as 'UPLINK NETWORK CAPABILITY - NUMBER OF ERRORS IN ACCESSIBILITY [N]',
SUM(case when (ul.direction='Uplink' and ul.TestType='UL_NC' and ul.ErrorType='Retainability') then 1 else 0 end) as 'UPLINK NETWORK CAPABILITY - NUMBER OF ERRORS IN RETAINABILITY [N]',

SUM(case when (ul.direction='Uplink' and ul.TestType='UL_NC' and ISNULL(ul.Throughput,0)>64) then 1 else 0 end) as 'UPLINK NETWORK CAPABILITY - NUMBERS OF SESSIONS WHOSE THROUGHPUT EXCEEDS 64 Kbps',

AVG(case when (ul.direction='Uplink' and ul.TestType='UL_NC' and ISNULL(ul.Throughput,0)>0) then ul.Throughput end) as 'UPLINK NETWORK CAPABILITY - MEAN DATA USER RATE [KBIT/S]',
(select Thput from #TH_PCT_UL_NC_STDEV_Indoor) as 'UPLINK NETWORK CAPABILITY - THROUGHPUT STANDARD DEVIATION',
--STDEV(case when (ul.direction='Uplink' and ul.TestType='UL_NC'  and ISNULL(ul.Throughput,0)>0) then ul.Throughput end) as 'UPLINK NETWORK CAPABILITY - THROUGHPUT STANDARD DEVIATION',
MAX(case when (ul.direction='Uplink' and ul.TestType='UL_NC'  and ISNULL(ul.Throughput,0)>0) then ul.Throughput end) as 'UPLINK NETWORK CAPABILITY - PEAK DATA USER RATE [KBIT/S]',

(select Thput10 from #TH_PCT_UL_NC_Pct10_Indoor)  as 'UPLINK NETWORK CAPABILITY - 10TH PERCENTILE THR',
 
null as 'UPLINK NETWORK CAPABILITY - 10TH THR. (CALCULATED ON ALL MAIN CITIES AGGREGATION ) ',
null as 'UPLINK NETWORK CAPABILITY - 10TH THR. (CALCULATED ON ALL MAIN AND SMALLER CITIES AGGREGATION)',

(select Thput90 from #TH_PCT_UL_NC_Pct90_Indoor)  as 'UPLINK NETWORK CAPABILITY - 90TH PERCENTILE THR',
 
null as 'UPLINK NETWORK CAPABILITY - 90TH THR. (CALCULATED ON ALL MAIN CITIES AGGREGATION) ',
null as 'UPLINK NETWORK CAPABILITY - 90TH THR. (CALCULATED ON ALL MAIN AND SMALLER CITIES AGGREGATION)',


-----------
-- LATENCY:
(select pings from #Ping_indoor) as 'LATENCY - NUMBER OF PINGS [N]',
(select floor([Latency Median]) from #Ping_median_indoor) as 'LATENCY - [MSEC] MEDIAN',
(select [AVG PING] from #Ping_indoor) as 'LATENCY - [MSEC] AVG',
'' as 'LATENCY - [MSEC] MEDIAN (CALCULATED ON AGGREGATION/ROUTES ) ',
'' as 'LATENCY - D4.LATENCY [MSEC] MEDIAN (CALCULATED ON ALL MAIN AND SMALLER CITIES AGGREGATION)',

-----------
-- BROWSING HTTP: - Faltan condiciones de tiempos por tipo de test
SUM(case when (web.typeoftest='HTTPBrowser' and web.protocol='HTTP' and web.TestType like '%Kepler%') then 1 else 0 end) as 'BROWSING - NUMBER OF ATTEMPTS [N]',

SUM(case when (web.typeoftest='HTTPBrowser' and web.protocol='HTTP' and web.TestType like '%Kepler%' and web.ErrorType='Accessibility') then 1 else 0 end) as 'BROWSING - NUMBER OF ERRORS IN ACCESSIBILITY [N]',
SUM(case when (web.typeoftest='HTTPBrowser' and web.protocol='HTTP' and web.TestType like '%Kepler%' and web.ErrorType='Retainability') then 1 else 0 end) as 'BROWSING - NUMBER OF ERRORS IN RETAINABILITY [N]',

AVG(case when (web.typeoftest='HTTPBrowser' and web.protocol='HTTP' and web.TestType like '%Kepler%' and ISNULL(web.[Session Time (s)],0)>0) then web.[Session Time (s)] end) as 'BROWSING - D5.SESSION TIME AVG [S]',
AVG(case when (web.typeoftest='HTTPBrowser' and web.protocol='HTTP' and web.TestType like '%Kepler%' and ISNULL(web.[IP Service Setup Time (s)],0)>0) then web.[IP Service Setup Time (s)] end) as 'BROWSING - IP SERVICE ACCESS TIME [S]',
AVG(case when (web.typeoftest='HTTPBrowser' and web.protocol='HTTP' and web.TestType like '%Kepler%' and ISNULL(web.[Transfer Time (s)] ,0)>0) then web.[Transfer Time (s)] end) as 'BROWSING - HTTP TRANSFER TIME [S]',

-- BROWSING HTTPS: - Faltan condiciones de tiempos por tipo de test
SUM(case when (web.typeoftest='HTTPBrowser' and web.protocol='HTTPS' and web.TestType like '%Kepler%') then 1 else 0 end) as 'BROWSING - NUMBER OF ATTEMPTS [N]',

SUM(case when (web.typeoftest='HTTPBrowser' and web.protocol='HTTPS' and web.TestType like '%Kepler%' and web.ErrorType='Accessibility') then 1 else 0 end) as 'BROWSING - NUMBER OF ERRORS IN ACCESSIBILITY [N]',
SUM(case when (web.typeoftest='HTTPBrowser' and web.protocol='HTTPS' and web.TestType like '%Kepler%' and web.ErrorType='Retainability') then 1 else 0 end) as 'BROWSING - NUMBER OF ERRORS IN RETAINABILITY [N]',

AVG(case when (web.typeoftest='HTTPBrowser' and web.protocol='HTTPS' and web.TestType like '%Kepler%' and ISNULL(web.[Session Time (s)],0)>0) then web.[Session Time (s)] end) as 'BROWSING - D5.SESSION TIME AVG [S]',
AVG(case when (web.typeoftest='HTTPBrowser' and web.protocol='HTTPS' and web.TestType like '%Kepler%' and ISNULL(web.[IP Service Setup Time (s)],0)>0) then web.[IP Service Setup Time (s)] end) as 'BROWSING - IP SERVICE ACCESS TIME [S]',
AVG(case when (web.typeoftest='HTTPBrowser' and web.protocol='HTTPS' and web.TestType like '%Kepler%' and ISNULL(web.[Transfer Time (s)] ,0)>0) then web.[Transfer Time (s)] end) as 'BROWSING - HTTP TRANSFER TIME [S]',


-------------
-- YOUTUBE HD:	ver como diferenciar SD de HD

--cast( avg(cast (left(ytb.[Video Resolution],3) as int)) as varchar(10)) + 'p' as 'YOU TUBE HD - B5 AVG  VIDEO RESOLUTION FOR QUALIFIED VIDEOS',
--SUM(case when ytb.typeoftest like '%YouTube%' and ytb.[Succeesful_Video_Download]='Successful' and ytb.[Video Resolution]='720p' then 1 else 0 end) as 'YOU TUBE - B4 HD SHARE - NUMBERS OF QUALIFIED VIDEO STARTED AND TERMINATED IN HD',
cast( avg(case when cast (left(ytb.[Video Resolution],3) as int)<= 720 or ytb.[Video Resolution] is null  then cast (left(ytb.[Video Resolution],3) as int)
			else 720 end
) as varchar(10)) + 'p' as 'YOU TUBE HD - B5 AVG  VIDEO RESOLUTION FOR QUALIFIED VIDEOS',

SUM(case when ytb.typeoftest like '%YouTube%' and ytb.[Succeesful_Video_Download]='Successful' 
				and cast (left(ytb.[Video Resolution],3) as int)>= 720 then 1 
	else 0 end
) as 'YOU TUBE - B4 HD SHARE - NUMBERS OF QUALIFIED VIDEO STARTED AND TERMINATED IN HD',

avg(ytb.Video_MOS) as 'YOU TUBE HD - B6 AVG  VIDEO MOS',

SUM(case when (ytb.typeoftest like '%YouTube%' /*and ytb.testname like '%HD%'*/) then 1 else 0 end) as 'YOU TUBE HD - NUMBER OF VIDEO ACCESS ATTEMPTS',

AVG(case when (ytb.typeoftest like '%YouTube%' /*and ytb.testname like '%HD%'*/) then ytb.[Time To First Image [s]]] end) as 'YOU TUBE HD - AVERAGE VIDEO START TIME [s]',

SUM(case when (ytb.Fails = 'Failed'/* and ytb.testname like '%HD%'*/) then 1 else 0 end) as 'YOU TUBE HD - NUMBER OF VIDEO FAILURES',

-- B1: Ratio from ACCESS to BUFFER phase, out of all attempts frop IP SERVICE ACCESS phase
case when SUM(case when ytb.typeoftest like '%YouTube%' /*and ytb.testname like '%HD%'*/ then 1 else 0 end)>0 then
(1 - (1.0*(SUM(case when (ytb.typeoftest like '%YouTube%' and ytb.Fails = 'Failed' /*and ytb.testname like '%HD%'*/) then 1 else 0 end)) 
	/ (SUM(case when (ytb.typeoftest like '%YouTube%'/* and ytb.testname like '%HD%'*/) then 1 else 0 end)))) else null end as 'YOU TUBE HD - B1 YOUTUBE SERVICE ACCESS SUCCESS RATIO',
	
SUM(case when ytb.typeoftest like '%YouTube%'/* and ytb.testname like '%HD%'*/ and ytb.[End Status]='W/O Interruptions' then 1 else 0 end)  as 'YOU TUBE HD - NUMBERS OF DL REPRODUCTION WITHOUT INTERRUPTIONS',

--SUM(case when ytb.typeoftest like '%YouTube%' /*and ytb.testname like '%HD%'*/ and ytb.[Video Resolution]='720p' then 1 else 0 end) as 'YOU TUBE HD - NUMBERS OF VIDEOS STARTED AND TERMINATED IN HD WITHOUT VIDEO COMPRESSION',
SUM(case when ytb.typeoftest like '%YouTube%' /*and ytb.testname like '%HD%'*/ 
		and cast (left(ytb.[Video Resolution],3) as int)>= 720 then 1 
	else 0 end
) as 'YOU TUBE HD - NUMBERS OF VIDEOS STARTED AND TERMINATED IN HD WITHOUT VIDEO COMPRESSION',

-- B2: Ratio from PLAYOUT phase, out of all attempts from IP SERVICE ACCESS phase
case when SUM(case when ytb.typeoftest like '%YouTube%' /*and ytb.testname like '%HD%'*/ then 1 else 0 end)>0 then
1.0*(SUM(case when ytb.typeoftest like '%YouTube%' /*and ytb.testname like '%HD%'*/ and ytb.[End Status]='W/O Interruptions' then 1 else 0 end)) 
	/ (SUM(case when (ytb.typeoftest like '%YouTube%' /*and ytb.testname like '%HD%'*/) then 1 else 0 end)) else null end as 'YOU TUBE HD - B2.YOUTUBE REPRODUCTION WITHOUT INTERRUPTIONS RATIO [%]',

--**********************************************************************************
-- DGP 27/08/2015: Se cambia la forma de calcular el B3 ya que se pide numero no %
-- *********************************************************************************

--B3: YOU TUBE  - SUCCESSFUL VIDEO DOWNLOAD
--case when SUM(case when ytb.typeoftest like '%YouTube%' and ytb.testname like '%HD%' then 1 else 0 end)>0 then
--	1.0*(SUM(case when ytb.typeoftest like '%YouTube%' and ytb.testname like '%HD%' and ytb.[Succeesful_Video_Download]='Successful' then 1 else 0 end)) 
--		/ (SUM(case when (ytb.typeoftest like '%YouTube%' and ytb.testname like '%HD%') then 1 else 0 end)) else null 
--end as 'YOU TUBE HD - SUCCESSFUL VIDEO DOWNLOAD [N] P3',

(SUM(case when ytb.typeoftest like '%YouTube%' /*and ytb.testname like '%HD%'*/ and ytb.[Succeesful_Video_Download]='Successful' then 1 else 0 end)) as 'YOU TUBE HD - SUCCESSFUL VIDEO DOWNLOAD [N] P3',


--Numbers of video downloads triggering in AND logic the following 4 criteria: 
	--(1) start within 10+23 sec 
	--(2) no single interruption greater than 8 sec 
	--(3) the sum of all interruptions is less than 15 sec 
	--(4) no more than 10 single interruptions								

-------------
-- UL CE:
SUM(case when (ul.direction='Uplink' and ul.TestType='UL_CE' and ul.Throughput>1000) then 1.0 end) 
		/  SUM(case when (ul.direction='Uplink' and ul.TestType='UL_CE') then 1 else 0 end) as 'UPLINK - ATTEMPTS OVER 1MB [%]',

--OSP:

1.0*((sum(isnull(dl.TCP_HandShake_Average,0))+sum(isnull(ul.TCP_HandShake_Average,0))+
	sum(isnull(web.TCP_HandShake_Average,0))+sum(isnull(ytb.TCP_HandShake_Average,0))))
	/	
	(nullif(sum((case when dl.TCP_HandShake_Average is not null then 1 else 0 end)+
	(case when ul.TCP_HandShake_Average is not null then 1 else 0 end) +
	(case when web.TCP_HandShake_Average is not null then 1 else 0 end) +
	(case when ytb.TCP_HandShake_Average is not null then 1 else 0 end)),0)) as 'TCP - 3WAY - HandShake AVG',

-- BROWSING HTTP: - Faltan condiciones de tiempos por tipo de test
SUM(case when (web.typeoftest='HTTPBrowser' and web.protocol='HTTP' and web.TestType not like '%Kepler%') then 1 else 0 end) as 'BROWSING - NUMBER OF ATTEMPTS [N]',

SUM(case when (web.typeoftest='HTTPBrowser' and web.protocol='HTTP' and web.TestType not like '%Kepler%' and web.ErrorType='Accessibility') then 1 else 0 end) as 'BROWSING - NUMBER OF ERRORS IN ACCESSIBILITY [N]',
SUM(case when (web.typeoftest='HTTPBrowser' and web.protocol='HTTP' and web.TestType not like '%Kepler%' and web.ErrorType='Retainability') then 1 else 0 end) as 'BROWSING - NUMBER OF ERRORS IN RETAINABILITY [N]',

AVG(case when (web.typeoftest='HTTPBrowser' and web.protocol='HTTP' and web.TestType not like '%Kepler%' and ISNULL(web.[Session Time (s)],0)>0) then web.[Session Time (s)] end) as 'BROWSING - D5.SESSION TIME AVG [S]',
AVG(case when (web.typeoftest='HTTPBrowser' and web.protocol='HTTP' and web.TestType not like '%Kepler%' and ISNULL(web.[IP Service Setup Time (s)],0)>0) then web.[IP Service Setup Time (s)] end) as 'BROWSING - IP SERVICE ACCESS TIME [S]',
AVG(case when (web.typeoftest='HTTPBrowser' and web.protocol='HTTP' and web.TestType not like '%Kepler%' and ISNULL(web.[Transfer Time (s)] ,0)>0) then web.[Transfer Time (s)] end) as 'BROWSING - HTTP TRANSFER TIME [S]'


from 
	TestInfo test,
	#All_Tests t
		LEFT OUTER JOIN Lcc_Data_HTTPTransfer_DL dl		on dl.sessionid=t.sessionid and dl.testid=t.testid
		LEFT OUTER JOIN Lcc_Data_HTTPTransfer_UL ul		on ul.sessionid=t.sessionid and ul.testid=t.testid
		LEFT OUTER JOIN Lcc_Data_HTTPBrowser web	on web.sessionid=t.sessionid and web.testid=t.testid		
		LEFT OUTER JOIN Lcc_Data_YOUTUBE ytb	on ytb.sessionid=t.sessionid and ytb.testid=t.testid
		LEFT OUTER JOIN LCC_Data_Latencias lat	on lat.sessionid=t.sessionid and lat.testid=t.testid
		LEFT OUTER JOIN Agrids.dbo.lcc_parcelas lp	on lp.Nombre= master.dbo.fn_lcc_getParcel(t.[Longitud Final], t.[Latitud Final])
where test.SessionId=t.SessionId and test.TestId=t.TestId
	and test.valid=1
	
-- DGP 16/09/2015: Si estamos en la hoja CA solo sacamos los resultados con Carrier Aggregation
	and t.hasCA like @CA
	OPTION (OPTIMIZE FOR UNKNOWN)
end 	
else
begin
select dl.TCP_HandShake_Average as TCP_dl, t.testid, dl.info, ul.TCP_HandShake_Average as TCP_ul, t.testid, ul.info, web.TCP_HandShake_Average as TCP_web,t.testid,web.info, ytb.TCP_HandShake_Average as TCP_ytb, t.testid, ytb.info, lat.TCP_HandShake_Average as TCP_lat, t.testid,lat.info
from 
 TestInfo test, 
 Agrids.dbo.lcc_parcelas lp,
 #All_Tests t

  LEFT OUTER JOIN Lcc_Data_HTTPTransfer_DL dl  on dl.sessionid=t.sessionid and dl.testid=t.testid
  LEFT OUTER JOIN Lcc_Data_HTTPTransfer_UL ul  on ul.sessionid=t.sessionid and ul.testid=t.testid
  LEFT OUTER JOIN Lcc_Data_HTTPBrowser web on web.sessionid=t.sessionid and web.testid=t.testid  
  LEFT OUTER JOIN Lcc_Data_YOUTUBE ytb on ytb.sessionid=t.sessionid and ytb.testid=t.testid
  LEFT OUTER JOIN LCC_Data_Latencias lat on lat.sessionid=t.sessionid and lat.testid=t.testid
  
where test.SessionId=t.SessionId and test.TestId=t.TestId
 and test.valid=1
 and lp.Nombre= master.dbo.fn_lcc_getParcel(t.[Longitud Final], t.[Latitud Final])
 and lp.entorno like @Environ
 
-- DGP 16/09/2015: Si estamos en la hoja CA solo sacamos los resultados con Carrier Aggregation
 and t.hasCA like @CA
 OPTION (OPTIMIZE FOR UNKNOWN)

select 
-----------
-- DL CE:
SUM(case when (dl.direction='Downlink' and dl.TestType='DL_CE') then 1 else 0 end) as 'DOWNLINK - NUMBER OF ATTEMPTS [N]',
SUM(case when (dl.direction='Downlink' and dl.TestType='DL_CE' and dl.ErrorType='Accessibility') then 1 else 0 end) as 'DOWNLINK - NUMBER OF ERRORS IN ACCESSIBILITY [N]',
SUM(case when (dl.direction='Downlink' and dl.TestType='DL_CE' and dl.ErrorType='Retainability') then 1 else 0 end) as 'DOWNLINK - NUMBER OF ERRORS IN RETAINABILITY [N]',

AVG(case when (dl.direction='Downlink' and dl.TestType='DL_CE' and ISNULL(dl.Throughput,0)>0) then dl.Throughput end) as 'DOWNLINK - D1.DOWNLOAD SPEED [KBIT/S] AVG',
(select Thput from #TH_PCT_DL_CE_STDEV) as 'DOWNLINK - THROUGHPUT STANDARD DEVIATION',
--STDEV(case when (dl.direction='Downlink' and dl.TestType='DL_CE' and ISNULL(dl.Throughput,0)>0) then dl.Throughput end) as 'DOWNLINK - THROUGHPUT STANDARD DEVIATION',

case when (SUM (case when (dl.direction='Downlink' and dl.TestType='DL_CE' and ISNULL(dl.Throughput,0)>0) then 1 else 0 end)) = 0 then 0 
	else (1.0*SUM(case when (dl.direction='Downlink' and dl.TestType='DL_CE' and ISNULL(dl.Throughput,0)>3000) then 1 else 0 end)
		/SUM (case when (dl.direction='Downlink' and dl.TestType='DL_CE' and ISNULL(dl.Throughput,0)>0) then 1 else 0 end)) end as 'DOWNLINK - D2. PERCENTAGE OF DL CONNECTIONS WITH THROUGHPUT > 3 MBPS',
		
SUM(case when (dl.direction='Downlink' and dl.TestType='DL_CE' and ISNULL(dl.Throughput,0)>3000) then 1 else 0 end)  as 'DOWNLINK - NUMBER OF DL WITH TROUGHPUT > 3 MBPS',
SUM(case when (dl.direction='Downlink' and dl.TestType='DL_CE' and ISNULL(dl.Throughput,0)>1000) then 1 else 0 end)  as 'DOWNLINK - NUMBER OF DL WITH THROUGHPUT > 1 MBPS',
MAX(case when (dl.direction='Downlink' and dl.TestType='DL_CE' and ISNULL(dl.Throughput,0)>0) then dl.Throughput end) as 'DOWNLINK - PEAK DATA USER RATE [KBIT/S]',

(select Thput10 from #TH_PCT_DL_CE_Pct10)	as 'DOWNLINK - 10TH PERCENTILE THR',
 
null as 'DOWNLINK - 10TH THR. (CALCULATED ON ALL MAIN CITIES AGGREGATION ) ',
null as 'DOWNLINK - 10TH THR. (CALCULATED ON ALL MAIN AND SMALLER CITIES AGGREGATION)',

(select Thput90 from #TH_PCT_DL_CE_Pct90) as 'DOWNLINK - 90TH PERCENTILE THR',
 
null as 'DOWNLINK - 90TH THR. (CALCULATED ON ALL MAIN CITIES AGGREGATION ) ',
null as 'DOWNLINK - 90TH THR. (CALCULATED ON ALL MAIN AND SMALLER CITIES AGGREGATION)',


-----------
-- UL CE:
SUM(case when (ul.direction='Uplink' and ul.TestType='UL_CE') then 1 else 0 end) as 'UPLINK - NUMBER OF ATTEMPTS [N]',
SUM(case when (ul.direction='Uplink' and ul.TestType='UL_CE' and ul.ErrorType='Accessibility') then 1 else 0 end) as 'UPLINK - NUMBER OF ERRORS IN ACCESSIBILITY [N]',
SUM(case when (ul.direction='Uplink' and ul.TestType='UL_CE' and ul.ErrorType='Retainability') then 1 else 0 end) as 'UPLINK - NUMBER OF ERRORS IN RETAINABILITY [N]',

AVG(case when (ul.direction='Uplink' and ul.TestType='UL_CE' and ISNULL(ul.Throughput,0)>0) then ul.Throughput end) as 'UPLINK - D3.UPLOAD SPEED [KBIT/S] AVG',
(select Thput from #TH_PCT_UL_CE_STDEV) as 'UPLINK - THROUGHPUT STANDARD DEVIATION',
--STDEV(case when (ul.direction='Uplink' and ul.TestType='UL_CE' and ISNULL(ul.Throughput,0)>0) then ul.Throughput end) as 'UPLINK - THROUGHPUT STANDARD DEVIATION',
MAX(case when (ul.direction='Uplink' and ul.TestType='UL_CE' and ISNULL(ul.Throughput,0)>0) then ul.Throughput end) as 'UPLINK - PEAK DATA USER RATE [KBIT/S]',

(select Thput10 from #TH_PCT_UL_CE_Pct10) as 'UPLINK - 10TH PERCENTILE THR',
 
null as 'UPLINK - 10TH THR. (CALCULATED ON ALL MAIN CITIES AGGREGATION )',
null as 'UPLINK - 10TH THR. (CALCULATED ON ALL MAIN AND SMALLER CITIES AGGREGATION)',

(select Thput90 from #TH_PCT_UL_CE_Pct90) as 'UPLINK - 90TH PERCENTILE THR',
 
null as 'UPLINK - 90TH THR. (CALCULATED ON ALL MAIN CITIES AGGREGATION ) ',
null as 'UPLINK - 90TH THR. (CALCULATED ON ALL MAIN AND SMALLER CITIES AGGREGATION)',

-----------
-- DL NC:
SUM(case when (dl.direction='Downlink' and dl.TestType='DL_NC') then 1 else 0 end) as 'DOWNLINK NETWORK CAPABILITY - NUMBER OF ATTEMPTS [N]',
SUM(case when (dl.direction='Downlink' and dl.TestType='DL_NC' and dl.ErrorType='Accessibility') then 1 else 0 end) as 'DOWNLINK NETWORK CAPABILITY - NUMBER OF ERRORS IN ACCESSIBILITY [N]',
SUM(case when (dl.direction='Downlink' and dl.TestType='DL_NC' and dl.ErrorType='Retainability') then 1 else 0 end) as 'DOWNLINK NETWORK CAPABILITY - NUMBER OF ERRORS IN RETAINABILITY [N]',

SUM(case when (dl.direction='Downlink' and dl.TestType='DL_NC' and ISNULL(dl.Throughput,0)>128) then 1 else 0 end) as 'DOWNLINK NETWORK CAPABILITY - NUMBERS OF SESSIONS WHOSE THROUGHPUT EXCEEDS 128 Kbps',

AVG(case when (dl.direction='Downlink' and dl.TestType='DL_NC' and ISNULL(dl.Throughput,0)>0) then dl.Throughput end) as 'DOWNLINK NETWORK CAPABILITY - MEAN DATA USER RATE [KBIT/S]',
(select Thput from #TH_PCT_DL_NC_STDEV) as 'DOWNLINK NETWORK CAPABILITY - THROUGHPUT STANDARD DEVIATION',
--STDEV(case when (dl.direction='Downlink' and dl.TestType='DL_NC' and ISNULL(dl.Throughput,0)>0) then dl.Throughput end) as 'DOWNLINK NETWORK CAPABILITY - THROUGHPUT STANDARD DEVIATION',
MAX(case when (dl.direction='Downlink' and dl.TestType='DL_NC' and ISNULL(dl.Throughput,0)>0) then dl.Throughput end) as 'DOWNLINK NETWORK CAPABILITY - PEAK DATA USER RATE [KBIT/S]',

(select Thput10 from #TH_PCT_DL_NC_Pct10) as 'DOWNLINK NETWORK CAPABILITY - 10TH PERCENTILE THR',
 
null as 'DOWNLINK NETWORK CAPABILITY - 10TH THR. (CALCULATED ON ALL MAIN CITIES AGGREGATION ) ',
null as 'DOWNLINK NETWORK CAPABILITY - 10TH THR. (CALCULATED ON ALL MAIN AND SMALLER CITIES AGGREGATION)',

(select Thput90 from #TH_PCT_DL_NC_Pct90) as 'DOWNLINK NETWORK CAPABILITY - 90TH PERCENTILE THR',

null as 'DOWNLINK NETWORK CAPABILITY - 90TH THR. (CALCULATED ON ALL MAIN CITIES AGGREGATION ) ',
null as 'DOWNLINK NETWORK CAPABILITY - 90TH THR. (CALCULATED ON ALL MAIN AND SMALLER CITIES AGGREGATION)',

-----------
-- UL NC:
SUM(case when (ul.direction='Uplink' and ul.TestType='UL_NC') then 1 else 0 end) as 'UPLINK NETWORK CAPABILITY - NUMBER OF ATTEMPTS [N]',
SUM(case when (ul.direction='Uplink' and ul.TestType='UL_NC' and ul.ErrorType='Accessibility') then 1 else 0 end) as 'UPLINK NETWORK CAPABILITY - NUMBER OF ERRORS IN ACCESSIBILITY [N]',
SUM(case when (ul.direction='Uplink' and ul.TestType='UL_NC' and ul.ErrorType='Retainability') then 1 else 0 end) as 'UPLINK NETWORK CAPABILITY - NUMBER OF ERRORS IN RETAINABILITY [N]',

SUM(case when (ul.direction='Uplink' and ul.TestType='UL_NC' and ISNULL(ul.Throughput,0)>64) then 1 else 0 end) as 'UPLINK NETWORK CAPABILITY - NUMBERS OF SESSIONS WHOSE THROUGHPUT EXCEEDS 64 Kbps',

AVG(case when (ul.direction='Uplink' and ul.TestType='UL_NC' and ISNULL(ul.Throughput,0)>0) then ul.Throughput end) as 'UPLINK NETWORK CAPABILITY - MEAN DATA USER RATE [KBIT/S]',
(select Thput from #TH_PCT_UL_NC_STDEV) as 'UPLINK NETWORK CAPABILITY - THROUGHPUT STANDARD DEVIATION',
--STDEV(case when (ul.direction='Uplink' and ul.TestType='UL_NC'  and ISNULL(ul.Throughput,0)>0) then ul.Throughput end) as 'UPLINK NETWORK CAPABILITY - THROUGHPUT STANDARD DEVIATION',
MAX(case when (ul.direction='Uplink' and ul.TestType='UL_NC'  and ISNULL(ul.Throughput,0)>0) then ul.Throughput end) as 'UPLINK NETWORK CAPABILITY - PEAK DATA USER RATE [KBIT/S]',

(select Thput10 from #TH_PCT_UL_NC_Pct10)  as 'UPLINK NETWORK CAPABILITY - 10TH PERCENTILE THR',
 
null as 'UPLINK NETWORK CAPABILITY - 10TH THR. (CALCULATED ON ALL MAIN CITIES AGGREGATION ) ',
null as 'UPLINK NETWORK CAPABILITY - 10TH THR. (CALCULATED ON ALL MAIN AND SMALLER CITIES AGGREGATION)',

(select Thput90 from #TH_PCT_UL_NC_Pct90)  as 'UPLINK NETWORK CAPABILITY - 90TH PERCENTILE THR',
 
null as 'UPLINK NETWORK CAPABILITY - 90TH THR. (CALCULATED ON ALL MAIN CITIES AGGREGATION) ',
null as 'UPLINK NETWORK CAPABILITY - 90TH THR. (CALCULATED ON ALL MAIN AND SMALLER CITIES AGGREGATION)',


-----------
-- LATENCY:
(select pings from #Ping) as 'LATENCY - NUMBER OF PINGS [N]',
(select floor([Latency Median]) from #Ping_median) as 'LATENCY - [MSEC] MEDIAN',
(select [AVG PING] from #Ping) as 'LATENCY - [MSEC] AVG',
'' as 'LATENCY - [MSEC] MEDIAN (CALCULATED ON AGGREGATION/ROUTES ) ',
'' as 'LATENCY - D4.LATENCY [MSEC] MEDIAN (CALCULATED ON ALL MAIN AND SMALLER CITIES AGGREGATION)',


-----------
-- BROWSING HTTP: - Faltan condiciones de tiempos por tipo de test
SUM(case when (web.typeoftest='HTTPBrowser' and web.protocol='HTTP' and web.TestType like '%Kepler%') then 1 else 0 end) as 'BROWSING - NUMBER OF ATTEMPTS [N]',

SUM(case when (web.typeoftest='HTTPBrowser' and web.protocol='HTTP' and web.TestType like '%Kepler%' and web.ErrorType='Accessibility') then 1 else 0 end) as 'BROWSING - NUMBER OF ERRORS IN ACCESSIBILITY [N]',
SUM(case when (web.typeoftest='HTTPBrowser' and web.protocol='HTTP' and web.TestType like '%Kepler%' and web.ErrorType='Retainability') then 1 else 0 end) as 'BROWSING - NUMBER OF ERRORS IN RETAINABILITY [N]',

AVG(case when (web.typeoftest='HTTPBrowser' and web.protocol='HTTP' and web.TestType like '%Kepler%' and ISNULL(web.[Session Time (s)],0)>0) then web.[Session Time (s)] end) as 'BROWSING - D5.SESSION TIME AVG [S]',
AVG(case when (web.typeoftest='HTTPBrowser' and web.protocol='HTTP' and web.TestType like '%Kepler%' and ISNULL(web.[IP Service Setup Time (s)],0)>0) then web.[IP Service Setup Time (s)] end) as 'BROWSING - IP SERVICE ACCESS TIME [S]',
AVG(case when (web.typeoftest='HTTPBrowser' and web.protocol='HTTP' and web.TestType like '%Kepler%' and ISNULL(web.[Transfer Time (s)] ,0)>0) then web.[Transfer Time (s)] end) as 'BROWSING - HTTP TRANSFER TIME [S]',

-- BROWSING HTTPS: - Faltan condiciones de tiempos por tipo de test
SUM(case when (web.typeoftest='HTTPBrowser' and web.protocol='HTTPS' and web.TestType like '%Kepler%') then 1 else 0 end) as 'BROWSING - NUMBER OF ATTEMPTS [N]',

SUM(case when (web.typeoftest='HTTPBrowser' and web.protocol='HTTPS' and web.TestType like '%Kepler%' and web.ErrorType='Accessibility') then 1 else 0 end) as 'BROWSING - NUMBER OF ERRORS IN ACCESSIBILITY [N]',
SUM(case when (web.typeoftest='HTTPBrowser' and web.protocol='HTTPS' and web.TestType like '%Kepler%' and web.ErrorType='Retainability') then 1 else 0 end) as 'BROWSING - NUMBER OF ERRORS IN RETAINABILITY [N]',

AVG(case when (web.typeoftest='HTTPBrowser' and web.protocol='HTTPS' and web.TestType like '%Kepler%' and ISNULL(web.[Session Time (s)],0)>0) then web.[Session Time (s)] end) as 'BROWSING - D5.SESSION TIME AVG [S]',
AVG(case when (web.typeoftest='HTTPBrowser' and web.protocol='HTTPS' and web.TestType like '%Kepler%' and ISNULL(web.[IP Service Setup Time (s)],0)>0) then web.[IP Service Setup Time (s)] end) as 'BROWSING - IP SERVICE ACCESS TIME [S]',
AVG(case when (web.typeoftest='HTTPBrowser' and web.protocol='HTTPS' and web.TestType like '%Kepler%' and ISNULL(web.[Transfer Time (s)] ,0)>0) then web.[Transfer Time (s)] end) as 'BROWSING - HTTP TRANSFER TIME [S]',


-------------
-- YOUTUBE HD:	ver como diferenciar SD de HD

cast( avg(case when cast (left(ytb.[Video Resolution],3) as int)<= 720 or ytb.[Video Resolution] is null then cast (left(ytb.[Video Resolution],3) as int)
			else 720 end
) as varchar(10)) + 'p' as 'YOU TUBE HD - B5 AVG  VIDEO RESOLUTION FOR QUALIFIED VIDEOS',

SUM(case when ytb.typeoftest like '%YouTube%' and ytb.[Succeesful_Video_Download]='Successful' 
		and cast (left(ytb.[Video Resolution],3) as int)>= 720 then 1 
	else 0 end
) as 'YOU TUBE - B4 HD SHARE - NUMBERS OF QUALIFIED VIDEO STARTED AND TERMINATED IN HD',

avg(ytb.Video_MOS) as 'YOU TUBE HD - B6 AVG  VIDEO MOS',

SUM(case when (ytb.typeoftest like '%YouTube%' /*and ytb.testname like '%HD%'*/) then 1 else 0 end) as 'YOU TUBE HD - NUMBER OF VIDEO ACCESS ATTEMPTS',

AVG(case when (ytb.typeoftest like '%YouTube%' /*and ytb.testname like '%HD%'*/) then ytb.[Time To First Image [s]]] end) as 'YOU TUBE HD - AVERAGE VIDEO START TIME [s]',

SUM(case when (ytb.Fails = 'Failed' /*and ytb.testname like '%HD%'*/) then 1 else 0 end) as 'YOU TUBE HD - NUMBER OF VIDEO FAILURES',

-- B1: Ratio from ACCESS to BUFFER phase, out of all attempts frop IP SERVICE ACCESS phase
case when SUM(case when ytb.typeoftest like '%YouTube%' /*and ytb.testname like '%HD%'*/ then 1 else 0 end)>0 then
(1 - (1.0*(SUM(case when (ytb.typeoftest like '%YouTube%' and ytb.Fails = 'Failed' /*and ytb.testname like '%HD%'*/) then 1 else 0 end)) 
	/ (SUM(case when (ytb.typeoftest like '%YouTube%' /*and ytb.testname like '%HD%'*/) then 1 else 0 end)))) else null end as 'YOU TUBE HD - B1 YOUTUBE SERVICE ACCESS SUCCESS RATIO',
	
SUM(case when ytb.typeoftest like '%YouTube%' /*and ytb.testname like '%HD%'*/ and ytb.[End Status]='W/O Interruptions' then 1 else 0 end)  as 'YOU TUBE HD - NUMBERS OF DL REPRODUCTION WITHOUT INTERRUPTIONS',

SUM(case when ytb.typeoftest like '%YouTube%' /*and ytb.testname like '%HD%'*/ 
		and cast (left(ytb.[Video Resolution],3) as int)>= 720 then 1 
	else 0 end
) as 'YOU TUBE HD - NUMBERS OF VIDEOS STARTED AND TERMINATED IN HD WITHOUT VIDEO COMPRESSION',

-- B2: Ratio from PLAYOUT phase, out of all attempts from IP SERVICE ACCESS phase
case when SUM(case when ytb.typeoftest like '%YouTube%' /*and ytb.testname like '%HD%' */then 1 else 0 end)>0 then
1.0*(SUM(case when ytb.typeoftest like '%YouTube%' /*and ytb.testname like '%HD%'*/ and ytb.[End Status]='W/O Interruptions' then 1 else 0 end)) 
	/ (SUM(case when (ytb.typeoftest like '%YouTube%' /*and ytb.testname like '%HD%'*/) then 1 else 0 end)) else null end as 'YOU TUBE HD - B2.YOUTUBE REPRODUCTION WITHOUT INTERRUPTIONS RATIO [%]',

--**********************************************************************************
-- DGP 27/08/2015: Se cambia la forma de calcular el B3 ya que se pide numero no %
-- *********************************************************************************

--B3: YOU TUBE  - SUCCESSFUL VIDEO DOWNLOAD
--case when SUM(case when ytb.typeoftest like '%YouTube%' and ytb.testname like '%HD%' then 1 else 0 end)>0 then
--	1.0*(SUM(case when ytb.typeoftest like '%YouTube%' and ytb.testname like '%HD%' and ytb.[Succeesful_Video_Download]='Successful' then 1 else 0 end)) 
--		/ (SUM(case when (ytb.typeoftest like '%YouTube%' and ytb.testname like '%HD%') then 1 else 0 end)) else null 
--end as 'YOU TUBE HD - SUCCESSFUL VIDEO DOWNLOAD [N] P3',

(SUM(case when ytb.typeoftest like '%YouTube%' /*and ytb.testname like '%HD%'*/ and ytb.[Succeesful_Video_Download]='Successful' then 1 else 0 end)) as 'YOU TUBE HD - SUCCESSFUL VIDEO DOWNLOAD [N] P3',


--Numbers of video downloads triggering in AND logic the following 4 criteria: 
	--(1) start within 10+23 sec 
	--(2) no single interruption greater than 8 sec 
	--(3) the sum of all interruptions is less than 15 sec 
	--(4) no more than 10 single interruptions								

-------------
-- UL CE:
SUM(case when (ul.direction='Uplink' and ul.TestType='UL_CE' and ul.Throughput>1000) then 1.0 end) 
		/  SUM(case when (ul.direction='Uplink' and ul.TestType='UL_CE') then 1 else 0 end) as 'UPLINK - ATTEMPTS OVER 1MB [%]',

--OSP:

1.0*((sum(isnull(dl.TCP_HandShake_Average,0))+sum(isnull(ul.TCP_HandShake_Average,0))+
	sum(isnull(web.TCP_HandShake_Average,0))+sum(isnull(ytb.TCP_HandShake_Average,0))))
	/	
	(nullif(sum((case when dl.TCP_HandShake_Average is not null then 1 else 0 end)+
	(case when ul.TCP_HandShake_Average is not null then 1 else 0 end) +
	(case when web.TCP_HandShake_Average is not null then 1 else 0 end) +
	(case when ytb.TCP_HandShake_Average is not null then 1 else 0 end)),0)) as 'TCP - 3WAY - HandShake AVG',

-- BROWSING HTTP: - Faltan condiciones de tiempos por tipo de test
SUM(case when (web.typeoftest='HTTPBrowser' and web.protocol='HTTP' and web.TestType not like '%Kepler%') then 1 else 0 end) as 'BROWSING - NUMBER OF ATTEMPTS [N]',

SUM(case when (web.typeoftest='HTTPBrowser' and web.protocol='HTTP' and web.TestType not like '%Kepler%' and web.ErrorType='Accessibility') then 1 else 0 end) as 'BROWSING - NUMBER OF ERRORS IN ACCESSIBILITY [N]',
SUM(case when (web.typeoftest='HTTPBrowser' and web.protocol='HTTP' and web.TestType not like '%Kepler%' and web.ErrorType='Retainability') then 1 else 0 end) as 'BROWSING - NUMBER OF ERRORS IN RETAINABILITY [N]',

AVG(case when (web.typeoftest='HTTPBrowser' and web.protocol='HTTP' and web.TestType not like '%Kepler%' and ISNULL(web.[Session Time (s)],0)>0) then web.[Session Time (s)] end) as 'BROWSING - D5.SESSION TIME AVG [S]',
AVG(case when (web.typeoftest='HTTPBrowser' and web.protocol='HTTP' and web.TestType not like '%Kepler%' and ISNULL(web.[IP Service Setup Time (s)],0)>0) then web.[IP Service Setup Time (s)] end) as 'BROWSING - IP SERVICE ACCESS TIME [S]',
AVG(case when (web.typeoftest='HTTPBrowser' and web.protocol='HTTP' and web.TestType not like '%Kepler%' and ISNULL(web.[Transfer Time (s)] ,0)>0) then web.[Transfer Time (s)] end) as 'BROWSING - HTTP TRANSFER TIME [S]'


from 
	TestInfo test,
	Agrids.dbo.lcc_parcelas lp,
	#All_Tests t
		LEFT OUTER JOIN Lcc_Data_HTTPTransfer_DL dl		on dl.sessionid=t.sessionid and dl.testid=t.testid
		LEFT OUTER JOIN Lcc_Data_HTTPTransfer_UL ul		on ul.sessionid=t.sessionid and ul.testid=t.testid
		LEFT OUTER JOIN Lcc_Data_HTTPBrowser web	on web.sessionid=t.sessionid and web.testid=t.testid		
		LEFT OUTER JOIN Lcc_Data_YOUTUBE ytb	on ytb.sessionid=t.sessionid and ytb.testid=t.testid
		LEFT OUTER JOIN LCC_Data_Latencias lat	on lat.sessionid=t.sessionid and lat.testid=t.testid
		
where test.SessionId=t.SessionId and test.TestId=t.TestId
	and test.valid=1
	and lp.Nombre= master.dbo.fn_lcc_getParcel(t.[Longitud Final], t.[Latitud Final])
	and lp.entorno like @Environ
	
-- DGP 16/09/2015: Si estamos en la hoja CA solo sacamos los resultados con Carrier Aggregation
	and t.hasCA like @CA
	OPTION (OPTIMIZE FOR UNKNOWN)
end




if (db_name() like '%Indoor%' or db_name() like '%AVE%')
	begin
		drop table
		#All_Tests_DL_Tech, #All_Tests_LAT, #All_Tests_LAT_Tech, #All_Tests_UL_Tech, #All_Tests_WEB_Tech, #All_Tests_YTB_Tech, #All_Tests,
		#All_Tests_all_Tech,#Ping_indoor, #TH_perc_indoor,#TH_PCT_DL_indoor, #TH_PCT_UL_indoor, #TH_PCT_DL_CE_Pct10_indoor, #TH_PCT_DL_NC_Pct10_indoor,	#TH_PCT_UL_CE_Pct10_indoor, #TH_PCT_UL_NC_Pct10_indoor,
		#TH_PCT_DL_CE_Pct90_indoor, #TH_PCT_DL_NC_Pct90_indoor, #TH_PCT_UL_CE_Pct90_indoor, #TH_PCT_UL_NC_Pct90_indoor, #ping_perc_Indoor, #Ping_median_Indoor,
		#TH_PCT_DL_CE_STDEV_indoor, #TH_PCT_DL_NC_STDEV_indoor, #TH_PCT_UL_CE_STDEV_indoor, #TH_PCT_UL_NC_STDEV_indoor
	end

else

	begin
		drop table
		#All_Tests_DL_Tech, #All_Tests_LAT, #All_Tests_LAT_Tech, #All_Tests_UL_Tech, #All_Tests_WEB_Tech, #All_Tests_YTB_Tech, #All_Tests,
		#All_Tests_all_Tech, #Ping,	#TH_perc,#TH_PCT_DL, #TH_PCT_UL, #TH_PCT_DL_CE_Pct10, #TH_PCT_DL_NC_Pct10,	#TH_PCT_UL_CE_Pct10, #TH_PCT_UL_NC_Pct10,
		#TH_PCT_DL_CE_Pct90, #TH_PCT_DL_NC_Pct90, #TH_PCT_UL_CE_Pct90, #TH_PCT_UL_NC_Pct90, #ping_perc, #Ping_median,
		#TH_PCT_DL_CE_STDEV, #TH_PCT_DL_NC_STDEV, #TH_PCT_UL_CE_STDEV, #TH_PCT_UL_NC_STDEV
	end
