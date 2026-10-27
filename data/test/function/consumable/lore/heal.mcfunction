#> test:consumable/lore/heal
# @macro label: "HP" / "MP"、percent/flat: 回復量。「✚ HPを 最大値の20% + 10 回復」の1行を描く(0の方は出さない)

$scoreboard players set #lore_heal_pct test.temporary $(percent)
$scoreboard players set #lore_heal_flat test.temporary $(flat)

function test:item/weapon/lore/line_begin
data modify storage test: lore_work.line append value {text:"✚ ",color:"green"}
$data modify storage test: lore_work.line append value {text:"$(label)を ",color:"gray"}

execute if score #lore_heal_pct test.temporary matches 1.. run data modify storage test: lore_work.line append value {text:"最大値の",color:"gray"}
$execute if score #lore_heal_pct test.temporary matches 1.. run data modify storage test: lore_work.n set value $(percent)
execute if score #lore_heal_pct test.temporary matches 1.. run function test:item/weapon/lore/num
execute if score #lore_heal_pct test.temporary matches 1.. run data modify storage test: lore_work.line append value {text:"%",color:"aqua"}

execute if score #lore_heal_pct test.temporary matches 1.. if score #lore_heal_flat test.temporary matches 1.. run data modify storage test: lore_work.line append value {text:" + ",color:"gray"}

$execute if score #lore_heal_flat test.temporary matches 1.. run data modify storage test: lore_work.n set value $(flat)
execute if score #lore_heal_flat test.temporary matches 1.. run function test:item/weapon/lore/num

data modify storage test: lore_work.line append value {text:" 回復",color:"gray"}
function test:item/weapon/lore/commit
