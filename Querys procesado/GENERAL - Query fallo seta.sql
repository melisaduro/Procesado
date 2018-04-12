--QUERY CUANDO FALLA ALGO DE LA SETA. CREAR TABLAS


use [FY1617_Data_Rest_4G_H1_5]

select *
from [dbo].[Lcc_Data_Latencias_20161014] p, testinfo t
where 
t.testid=p.testid
and p.collectionname like '%chiva%'
and mnc=4



---------------------------
Microsoft Excel
---------------------------
exec sp_MDD_Data_NED_Libro_Resumen_KPIs_Extra_4G_FY1617_GRID 'CHIVA', '%%', 3, 'LTE', '%%', '4G', '%%', 'VDF'
---------------------------
Aceptar   
---------------------------
