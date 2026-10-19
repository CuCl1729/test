#> test:item/weapon/lore/special_buff
# @macro id: 命中時に付与するバフ1件(stacks/chanceはstorage test: lore_work.buffから読む)。
# 「☠ 命中時 30% で 毒 x1 を付与」の形。アイコン・表示名・色はバフのレジストリ(asset.buff.types)から引く。
# chanceが無ければ必ず付与されるので「命中時に」とだけ書く

function test:item/weapon/lore/line_begin
$data modify storage test: lore_work.line append from storage test: asset.buff.types[{id:"$(id)"}].icon
data modify storage test: lore_work.line append value {text:" 命中時",color:"gray"}

execute if data storage test: lore_work.buff.chance run data modify storage test: lore_work.line append value {text:" ",color:"gray"}
execute if data storage test: lore_work.buff.chance run data modify storage test: lore_work.n set from storage test: lore_work.buff.chance
execute if data storage test: lore_work.buff.chance run function test:item/weapon/lore/num
execute if data storage test: lore_work.buff.chance run data modify storage test: lore_work.line append value {text:"% で ",color:"gray"}
execute unless data storage test: lore_work.buff.chance run data modify storage test: lore_work.line append value {text:"に ",color:"gray"}

data modify storage test: lore_work.label set value {text:"",color:"white"}
$data modify storage test: lore_work.label.text set from storage test: asset.buff.types[{id:"$(id)"}].label
$data modify storage test: lore_work.label.color set from storage test: asset.buff.types[{id:"$(id)"}].color
data modify storage test: lore_work.line append from storage test: lore_work.label

data modify storage test: lore_work.line append value {text:" x",color:"gray"}
data modify storage test: lore_work.n set from storage test: lore_work.buff.stacks
function test:item/weapon/lore/num
data modify storage test: lore_work.line append value {text:" を付与",color:"gray"}

function test:item/weapon/lore/commit
