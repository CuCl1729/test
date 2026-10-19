#> test:item/weapon/lore/stat_line
# @macro type/sign: ステータスの種類と符号("" / "+")。値・強化回数はstorage test: lore_work.stat.value/.growから読む。
# 表示(アイコン・名前・色・単位)はinit/set_tableのloot.table.stat_displayから引く。
# 強化回数(grow)が1以上なら、後ろに金色の +N を付ける

$data modify storage test: lore_work.def set from storage test: loot.table.stat_display[{type:"$(type)"}]

function test:item/weapon/lore/line_begin
function test:item/weapon/lore/part_label with storage test: lore_work.def
$data modify storage test: lore_work.line append value {text:"$(sign)",color:"aqua"}

data modify storage test: lore_work.n set from storage test: lore_work.stat.value
function test:item/weapon/lore/num
function test:item/weapon/lore/part_unit with storage test: lore_work.def

scoreboard players set #lore_grow test.temporary 0
execute store result score #lore_grow test.temporary run data get storage test: lore_work.stat.grow
execute if score #lore_grow test.temporary matches 1.. run data modify storage test: lore_work.line append value {text:" +",color:"gold"}
execute if score #lore_grow test.temporary matches 1.. run data modify storage test: lore_work.n set from storage test: lore_work.stat.grow
execute if score #lore_grow test.temporary matches 1.. run function test:item/weapon/lore/num_colored {color:"gold"}

function test:item/weapon/lore/commit
