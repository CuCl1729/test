#> test:consumable/lore/self_buff
# @macro id/stacks: effect/self_buff と同じ引数。「▲ 自分に <バフの名前> x<段数> を付ける」の1行を描く
# (バフの名前と色は init/asset/buff/buffs のレジストリから引く)

function test:item/weapon/lore/line_begin
data modify storage test: lore_work.line append value {text:"▲ ",color:"gold"}
data modify storage test: lore_work.line append value {text:"自分に ",color:"gray"}
data modify storage test: lore_work.line append value {text:"",color:"gold"}
$data modify storage test: lore_work.line[-1].text set from storage test: asset.buff.types[{id:"$(id)"}].label
data modify storage test: lore_work.line append value {text:" x",color:"gray"}
$data modify storage test: lore_work.n set value $(stacks)
function test:item/weapon/lore/num
data modify storage test: lore_work.line append value {text:" を付ける",color:"gray"}
function test:item/weapon/lore/commit
