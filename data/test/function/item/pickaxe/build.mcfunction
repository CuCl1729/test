#> test:item/pickaxe/build
# @macro id: ツルハシのid。asset.pickaxe.<id> の定義から、ツルハシを storage test: loot.item に作る(item/material/build と同じ形)。
# - can_break: 掘れる鉱山の鉱石ブロックだけ壊せる(アドベンチャーモード用)
# - tool: そのブロックを speed で掘り、correct_for_drops を付ける(元のツルハシのランクに関係なく目印が落ちるように。
#   バニラの鉱石は正しい道具で掘らないと何も落とさない)
# - unbreakable: 耐久値は減らない(仮)
# 定義が無いidなら0、作れたら1を返す

$execute unless data storage test: asset.pickaxe.$(id) run return 0

data remove storage test: loot.item
$data modify storage test: loot.item.id set from storage test: asset.pickaxe.$(id).item
$data modify storage test: loot.item.components."minecraft:custom_data" set value {test:{pickaxe:{id:"$(id)",rank:0}}}
$data modify storage test: loot.item.components."minecraft:custom_data".test.pickaxe.rank set from storage test: asset.pickaxe.$(id).rank
data modify storage test: loot.item.components."minecraft:custom_name" set value {text:"",italic:false}
$data modify storage test: loot.item.components."minecraft:custom_name".text set from storage test: asset.pickaxe.$(id).name

data modify storage test: loot.item.components."minecraft:can_break" set value {blocks:[]}
$data modify storage test: loot.item.components."minecraft:can_break".blocks set from storage test: asset.pickaxe.$(id).blocks
data modify storage test: loot.item.components."minecraft:tool" set value {rules:[{blocks:[],speed:1.0f,correct_for_drops:true}],damage_per_block:0}
$data modify storage test: loot.item.components."minecraft:tool".rules[0].blocks set from storage test: asset.pickaxe.$(id).blocks
$data modify storage test: loot.item.components."minecraft:tool".rules[0].speed set from storage test: asset.pickaxe.$(id).speed
data modify storage test: loot.item.components."minecraft:unbreakable" set value {}
# 壊せるブロックの一覧などは説明文の邪魔になるので隠す
data modify storage test: loot.item.components."minecraft:tooltip_display" set value {hidden_components:["minecraft:can_break","minecraft:tool","minecraft:unbreakable","minecraft:attribute_modifiers"]}

$function test:item/pickaxe/lore with storage test: asset.pickaxe.$(id)
return 1
