
---Invalidamos muestas en parcelas conflictivas por problemas entorno incorrecto.---
---0.67512 Long, 38.26368 Lat  RoC   Invalidamos las muestras que haya en ella
---0.72168 Long, 38.25920 Lat  RoC   Invalidamos las muestras que haya en ella
 
--- VOZ---
use [FY1617_Voice_Smaller_4G_H1_3]
update sessions
set valid =0, InvalidReason= 'LCC OutOfBounds'
where valid =1
and sessionid in 
(
	select l.sessionid
	from Lcc_Calls_Detailed as l, Agrids.dbo.lcc_parcelas p
	where p.Nombre= master.dbo.fn_lcc_getParcel(l.longitude_fin_A,l.latitude_fin_A)
	and p.Nombre in (
			'-0.67512 Long, 38.26368 Lat',
			'-0.72168 Long, 38.25920 Lat'
					) 
	and l.collectionname like '%ELCHE%4g%'
)

---DATOS---
use [FY1617_Data_Smaller_4G_H1_3]
update testinfo
set valid =0, InvalidReason= 'LCC OutOfBounds'
where valid =1
and testid in 
(
	select l.testid
	from Lcc_Data_HTTPTransfer_DL as l, Agrids.dbo.lcc_parcelas p
	where p.Nombre= master.dbo.fn_lcc_getParcel(l.[Longitud Final],l.[Latitud Final])
	and p.Nombre in (
			'-0.67512 Long, 38.26368 Lat',
			'-0.72168 Long, 38.25920 Lat'
					) 
	and l.collectionname like '%ELCHE%4g%'

	union all
	select l.testid
	from Lcc_Data_HTTPTransfer_UL as l, Agrids.dbo.lcc_parcelas p
	where p.Nombre= master.dbo.fn_lcc_getParcel(l.[Longitud Final],l.[Latitud Final])
	and p.Nombre in (
			'-0.67512 Long, 38.26368 Lat',
			'-0.72168 Long, 38.25920 Lat'
					) 
	and l.collectionname like '%ELCHE%4g%'


	union all
	select l.testid
	from Lcc_Data_HTTPBrowser as l, Agrids.dbo.lcc_parcelas p
	where p.Nombre= master.dbo.fn_lcc_getParcel(l.[Longitud Final],l.[Latitud Final])
	and p.Nombre in (
			'-0.67512 Long, 38.26368 Lat',
			'-0.72168 Long, 38.25920 Lat'
					) 
	and l.collectionname like '%ELCHE%4g%'


	union all
	select l.testid
	from Lcc_Data_YOUTUBE as l, Agrids.dbo.lcc_parcelas p
	where p.Nombre= master.dbo.fn_lcc_getParcel(l.[Longitud Final],l.[Latitud Final])
	and p.Nombre in (
			'-0.67512 Long, 38.26368 Lat',
			'-0.72168 Long, 38.25920 Lat'
					) 
	and l.collectionname like '%ELCHE%4g%'


	union all
	select l.testid
	from Lcc_Data_Latencias as l, Agrids.dbo.lcc_parcelas p
	where p.Nombre= master.dbo.fn_lcc_getParcel(l.[Longitud Final],l.[Latitud Final])
	and p.Nombre in (
			'-0.67512 Long, 38.26368 Lat',
			'-0.72168 Long, 38.25920 Lat'
					) 
	and l.collectionname like '%ELCHE%4g%'

)


