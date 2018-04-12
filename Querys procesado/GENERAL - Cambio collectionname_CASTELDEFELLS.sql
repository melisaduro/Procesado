use FY1617_Voice_Rest_4G_H1_4

select * from filelist where collectionname like '%casteldefells%'
BEGIN TRANSACTION
declare @collectionname_ori as varchar(250)='20160919_ADD_B_CASTELLDEFELS_1_4G'
declare @collectionname_new as varchar(250)='20160919_ADD_B_CASTELDEFELLS_1_4G'

-----------------
-- Actualizacion:
update filelist
set collectionname=@collectionname_new
where collectionname=@collectionname_ori

-----------------
-- Tabla basica
update lcc_Calls_Detailed
set collectionname=@collectionname_new
where collectionname=@collectionname_ori

-----------------
-- Tablas scanner
update lcc_Scanner_GSM_Detailed
set collectionname=@collectionname_new
where collectionname=@collectionname_ori

update lcc_Scanner_LTE_Detailed
set collectionname=@collectionname_new
where collectionname=@collectionname_ori

update lcc_Scanner_UMTS_Detailed
set collectionname=@collectionname_new
where collectionname=@collectionname_ori

-----------------
-- Tablas extra
update lcc_Serving_Cell_Table
set collectionname=@collectionname_new
where collectionname=@collectionname_ori

update lcc_timelink_position
set collectionname=@collectionname_new
where collectionname=@collectionname_ori

-----------------
-- Tablas entity
update [lcc_position_Entity_List_Orange]		
set collectionname=@collectionname_new
where collectionname=@collectionname_ori

update [lcc_position_Entity_List_Vodafone]		
set collectionname=@collectionname_new
where collectionname=@collectionname_ori

update [lcc_position_Entity_List_Municipio]		
set collectionname=@collectionname_new
where collectionname=@collectionname_ori

-----------------
-- Tabla Celfinet
update [dbo].[lcc_CelfiNet_Sessions_List]
set collectionname=@collectionname_new
where collectionname=@collectionname_ori

-----------------
-- Tablas comparativa scn vs tlf:
update 	[dbo].[lcc_Cober_ue_4G]
set collectionname=@collectionname_new
where collectionname=@collectionname_ori

update [dbo].[lcc_Cober_ue_4G_b]
set collectionname=@collectionname_new
where collectionname=@collectionname_ori

update [dbo].[lcc_diff_SCN_TLF_4G_5]
set collectionname=@collectionname_new
where collectionname=@collectionname_ori

update [dbo].[lcc_diff_SCN_TLF_4G_5_b]
set collectionname=@collectionname_new
where collectionname=@collectionname_ori

update [dbo].[lcc_diff_SCN_TLF_4G_5_Hour]
set collectionname=@collectionname_new
where collectionname=@collectionname_ori

update [dbo].[lcc_diff_SCN_TLF_4G_5_hour_b]
set collectionname=@collectionname_new
where collectionname=@collectionname_ori

update [dbo].[lcc_diffScanTLF]
set collectionname=@collectionname_new
where collectionname=@collectionname_ori

COMMIT

----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------
--use FY1617_Data_Rest_4G_H1_5

----select * from filelist where collectionname like '%cambrils%'

--declare @collectionname_ori as varchar(250)='20161003_ADD_T_1_CAMBRILS_4G'
--declare @collectionname_new as varchar(250)='20161003_ADD_T_CAMBRILS_1_4G'


------ Actualizacion:
--update filelist
--set collectionname=@collectionname_new
--where collectionname=@collectionname_ori

---- Tablas basicas
--update [dbo].[Lcc_Data_HTTPBrowser]
--set collectionname=@collectionname_new
--where collectionname=@collectionname_ori

--update [Lcc_Data_HTTPTransfer_DL]
--set collectionname=@collectionname_new
--where collectionname=@collectionname_ori

--update [Lcc_Data_HTTPTransfer_UL]
--set collectionname=@collectionname_new
--where collectionname=@collectionname_ori

--update [Lcc_Data_Latencias]
--set collectionname=@collectionname_new
--where collectionname=@collectionname_ori

--update [Lcc_Data_YOUTUBE]
--set collectionname=@collectionname_new
--where collectionname=@collectionname_ori

---- Tablas extras
--update lcc_Serving_Cell_Table
--set collectionname=@collectionname_new
--where collectionname=@collectionname_ori

--update lcc_timelink_position
--set collectionname=@collectionname_new
--where collectionname=@collectionname_ori


---- Tablas entity
--update [lcc_position_Entity_List_Orange]		
--set collectionname=@collectionname_new
--where collectionname=@collectionname_ori

--update [lcc_position_Entity_List_Vodafone]		
--set collectionname=@collectionname_new
--where collectionname=@collectionname_ori

--update [lcc_position_Entity_List_Municipio]		
--set collectionname=@collectionname_new
--where collectionname=@collectionname_ori

---- Tabla Celfinet
--update 	[dbo].[lcc_CelfiNet_Tests_List]	
--set collectionname=@collectionname_new
--where collectionname=@collectionname_ori

---- Tablas comparativa scn vs tlf:
--update 	[dbo].[lcc_Cober_ue_4G]
--set collectionname=@collectionname_new
--where collectionname=@collectionname_ori

--update [dbo].[lcc_Cober_ue_4G_b]
--set collectionname=@collectionname_new
--where collectionname=@collectionname_ori

--update [dbo].[lcc_diff_SCN_TLF_4G_5]
--set collectionname=@collectionname_new
--where collectionname=@collectionname_ori

--update [dbo].[lcc_diff_SCN_TLF_4G_5_b]
--set collectionname=@collectionname_new
--where collectionname=@collectionname_ori

--update [dbo].[lcc_diff_SCN_TLF_4G_5_Hour]
--set collectionname=@collectionname_new
--where collectionname=@collectionname_ori

--update [dbo].[lcc_diff_SCN_TLF_4G_5_hour_b]
--set collectionname=@collectionname_new
--where collectionname=@collectionname_ori


---- Otras tablas
--update [dbo].[lcc_eficiencia_medidas_BM]
--set collectionname=@collectionname_new
--where collectionname=@collectionname_ori

