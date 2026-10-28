#> test:consumable/lore/self_buff
# @macro id/stacks: effect/self_buff と同じ引数。「▲ <バフの名前> x<段数>」の1行を描く(使った人に付く)
# (バフの名前は init/asset/buff/buffs のレジストリから引く)

function test:item/weapon/lore/line_begin
data modify storage test: lore_work.line append value {text:"▲ ",color:"gold"}
data modify storage test: lore_work.line append value {text:"",color:"gold"}
$data modify storage test: lore_work.line[-1].text set from storage test: asset.buff.types[{id:"$(id)"}].label
data modify storage test: lore_work.line append value {text:" x",color:"gray"}
$data modify storage test: lore_work.n set value $(stacks)
function test:item/weapon/lore/num
function test:item/weapon/lore/commit
