#> test:asset/equip/apply
# @s = アイテムを受け取る位置(ステーションのマーカーやプレイヤー)。@macro id: 作る装備(init/asset/equip/ の宣言)。
# storage test: loot.rare(3〜5、無ければサブステータス無し)に応じてサブステータスを付け、説明文を作って渡す。
# 武器の test:asset/weapon/sword/apply と同じ流れ(サブステータスは耐性を含む0..15から引く)

data remove storage test: loot.item
$data modify storage test: loot.item.id set from storage test: asset.equip.items.$(id).item
$data modify storage test: loot.item.components set from storage test: asset.equip.items.$(id).components
data modify storage test: loot.item.components."minecraft:custom_data".substatus set value []

data modify storage test: loot.substatus_max set value 15

scoreboard players set #loot test.substatus 0
execute if data storage test: {loot:{rare:3}} store result score #loot test.substatus run function test:rng/roll {key:"substatus_count",min:1,max:2}
execute if data storage test: {loot:{rare:4}} store result score #loot test.substatus run function test:rng/roll {key:"substatus_count",min:2,max:3}
execute if data storage test: {loot:{rare:5}} store result score #loot test.substatus run function test:rng/roll {key:"substatus_count",min:3,max:4}

execute if data storage test: {loot:{rare:3}} run data modify storage test: loot.item.components."minecraft:custom_name"[0].color set value dark_aqua
execute if data storage test: {loot:{rare:4}} run data modify storage test: loot.item.components."minecraft:custom_name"[0].color set value dark_purple
execute if data storage test: {loot:{rare:5}} run data modify storage test: loot.item.components."minecraft:custom_name"[0].color set value gold

scoreboard players set #level test.status.level 0

execute store result storage test: loot.substatus int 1 run function test:loot/roll_substatus_type
execute if score #loot test.substatus matches 1.. run function test:loot/set_substatus with storage test: loot

function test:item/weapon/lore/render
function test:loot/give
