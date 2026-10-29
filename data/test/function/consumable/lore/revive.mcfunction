#> test:consumable/lore/revive
# @macro percent/radius: effect/revive と同じ引数。「✚ 蘇生 HP30%」の1行を描く

function test:item/weapon/lore/line_begin
data modify storage test: lore_work.line append value {text:"✚ ",color:"green"}
data modify storage test: lore_work.line append value {text:"蘇生 HP",color:"gray"}
$data modify storage test: lore_work.n set value $(percent)
function test:item/weapon/lore/num
data modify storage test: lore_work.line append value {text:"%",color:"aqua"}
function test:item/weapon/lore/commit
