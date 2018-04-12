use [FY1617_Data_Smaller_3G_H1_3]

--update testinfo
--set valid = 0, InvalidReason = 'LCC OutOfBounds'
where valid = 1
and testid in  (
select a.testid 
from Lcc_Data_HTTPTransfer_DL as a, Agrids.dbo.lcc_parcelas lp
where lp.Nombre= master.dbo.fn_lcc_getParcel(a.[Longitud Final],a.[Latitud Final])
and lp.Nombre in ('-0.72168 Long, 38.27712 Lat')
and a.collectionname like '%elche%'
union all
select a.testid
from Lcc_Data_HTTPTransfer_UL as a, Agrids.dbo.lcc_parcelas lp
where lp.Nombre= master.dbo.fn_lcc_getParcel(a.[Longitud Final],a.[Latitud Final])
and lp.Nombre in ('-0.72168 Long, 38.27712 Lat')
and a.collectionname like '%elche%'
union all
select a.testid
from Lcc_Data_HTTPBrowser as a, Agrids.dbo.lcc_parcelas lp
where lp.Nombre= master.dbo.fn_lcc_getParcel(a.[Longitud Final],a.[Latitud Final])
and lp.Nombre in ('-0.72168 Long, 38.27712 Lat')
and a.collectionname like '%elche%'
union all
select a.testid
from Lcc_Data_YOUTUBE as a, Agrids.dbo.lcc_parcelas lp
where lp.Nombre= master.dbo.fn_lcc_getParcel(a.[Longitud Final],a.[Latitud Final])
and lp.Nombre in ('-0.72168 Long, 38.27712 Lat')
and a.collectionname like '%elche%'
union all
select a.testid
from Lcc_Data_Latencias as a, Agrids.dbo.lcc_parcelas lp
where lp.Nombre= master.dbo.fn_lcc_getParcel(a.[Longitud Final],a.[Latitud Final])
and lp.Nombre in ('-0.72168 Long, 38.27712 Lat')
and a.collectionname like '%elche%'
)


/*--71
188445
188463
189481
189490
189499
190497
191552
193423
193441
194307
194338
194347
195166
195197
188467
189485
189503
190501
190510
191556
191569
192560
194311
195170
190495
188442
188468
189505
189514
189487
194304
191571
189478
190494
190512
190521
191557
191580
189497
194305
188443
189488
191559
190513
192561
188461
195163
189479
192562
188460
193439
193421
191558
191572
192601
193420
195164
193438
192563
188465
189510
190508
191576
191554
194349
194309
189501
190499
189483
195168
195208
*/


/*
188445
188463
189481
189490
189499
190497
191552
193423
193441
194307
194338
194347
195166
195197
195206
188467
189485
189503
190501
190510
191556
191569
192560
194311
195170
190492
190495
188442
188468
189505
189514
189487
194304
189515
191571
189478
190494
190512
190521
191557
191580
189497
192603
194305
188443
189488
191559
190513
192561
192564
191581
188461
195163
189479
192562
188460
193439
193421
192602
191558
191572
192601
193420
193461
194324
195164
193438
195183
192563
188465
189510
190508
191576
191554
194349
194309
189501
190499
189483
195168
195208

*/