#> test:consumable/lore/heal
# @macro label: "HP" / "MP"、percent/flat: 回復量。「✚ HP回復 20%+10」の1行を描く(0の方は出さない)

$scoreboard players set #lore_heal_pct test.temporary $(percent)
$scoreboard players set #lore_heal_flat test.temporary $(flat)

function test:item/weapon/lore/line_begin
data modify storage test: lore_work.line append value {text:"✚ ",color:"green"}
$data modify storage test: lore_work.line append value {text:"$(label)回復 ",color:"gray"}

$execute if score #lore_heal_pct test.temporary matches 1.. run data modify storage test: lore_work.n set value $(percent)
execute if score #lore_heal_pct test.temporary matches 1.. run function test:item/weapon/lore/num
execute if score #lore_heal_pct test.temporary matches 1.. run data modify storage test: lore_work.line append value {text:"%",color:"aqua"}

execute if score #lore_heal_pct test.temporary matches 1.. if score #lore_heal_flat test.temporary matches 1.. run data modify storage test: lore_work.line append value {text:"+",color:"gray"}

$execute if score #lore_heal_flat test.temporary matches 1.. run data modify storage test: lore_work.n set value $(flat)
execute if score #lore_heal_flat test.temporary matches 1.. run function test:item/weapon/lore/num

function test:item/weapon/lore/commit
