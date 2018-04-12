--Query para comprobar si las llamadas están fuera de contorno

-- Tabla general contorno VDF
use AGRIDS_v2
select * from [dbo].[lcc_AGRIDS_Contornos_VF]
where entity_name like '%logrono%'

-- Tabla coordenadas llamadas

use FY1617_Voice_Smaller_VOLTE_2

select longitude_fin_A, latitude_fin_A, longitude_fin_B, latitude_fin_B
from lcc_Calls_Detailed
	where collectionname like '%logrocno%'
