#> test:battle/action/item_use
# @s = 手番のプレイヤー。@macro id: 使う消耗品のid(ほかのキーも渡ってくるが使わない)。
# 今使って意味が無ければ(倒れた味方がいないのに蘇生など。test:consumable/can_use)使わずに選び直しへ戻す。
# 持ち物から1個減らせたときだけ効果を実行し(test:consumable/use)、手番を終える

$execute store result score #item_can_use test.temporary run function test:consumable/can_use {id:"$(id)"}
execute if score #item_can_use test.temporary matches 0 run return run function test:battle/action/no_target

function test:battle/ui/cleanup

scoreboard players set #item_used test.temporary 0
$execute store success score #item_used test.temporary run clear @s *[custom_data~{test:{consumable:"$(id)"}}] 1
$execute if score #item_used test.temporary matches 1 run tellraw @a[distance=..64] ["",{selector:"@s"},{text:" は ",color:gray},{storage:"test:",nbt:"asset.consumable.$(id).name",color:green},{text:" を使った",color:gray}]
$execute if score #item_used test.temporary matches 1 run function test:consumable/use {id:"$(id)"}
execute if score #item_used test.temporary matches 0 run tellraw @s [{text:"アイテムがない",color:gray}]

function test:battle/turn_end
