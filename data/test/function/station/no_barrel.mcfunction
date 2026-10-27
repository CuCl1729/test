#> test:station/no_barrel
# @s = 樽が無くなったステーションのマーカー。@macro id: ステーションの種類。
# 壊された樽からは中身がばらまかれるので、UIアイテム(目印 station_ui / button / crafter_ui / job_ui の付いた物)を
# 拾われる前に消す(プレイヤーが置いた物はそのまま落ちる)。
# breakable なら樽も消してスポーンエッグを返し、マーカーごと消える。それ以外は置き直す

kill @e[type=item,distance=..2,nbt={Item:{components:{"minecraft:custom_data":{test:{station_ui:1b}}}}}]
kill @e[type=item,distance=..2,nbt={Item:{components:{"minecraft:custom_data":{test:{button:1b}}}}}]
kill @e[type=item,distance=..2,nbt={Item:{components:{"minecraft:custom_data":{test:{crafter_ui:1b}}}}}]
kill @e[type=item,distance=..2,nbt={Item:{components:{"minecraft:custom_data":{test:{job_ui:1b}}}}}]

$execute unless data storage test: asset.station.$(id){breakable:1b} run return run function test:station/place

kill @n[type=item,distance=..2,nbt={Item:{id:"minecraft:barrel"}}]
$function test:station/give_egg {id:"$(id)"}
tag @s add kill
