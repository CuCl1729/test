#> test:magic/crafter/keep_name_slot
# @s = 魔法台のマーカー(barrelの位置)。名前の枠(23)ができる前に置いた魔法台は、モードに入ったときの keep に 23 が無く、
# 板ガラスで埋まっている。一度だけ keep に足して、そこの板ガラス(UI用の物)を外す
data modify entity @s data.station.keep.s23 set value 1b
data remove block ~ ~ ~ Items[{Slot:23b,components:{"minecraft:custom_data":{test:{station_ui:1b}}}}]
