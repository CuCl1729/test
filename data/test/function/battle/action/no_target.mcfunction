#> test:battle/action/no_target
# @s = 手番のプレイヤー。選んだ行動に相手がいない(倒れた味方がいないのに蘇生など)ので、何も使わずに
# 行動の選び直しに戻す(手番は終えない)

tellraw @s [{text:"対象がいない",color:gray}]
function test:battle/ui/cleanup
execute if score @s test.settings.battle_ui matches 1 run function test:battle/ui/chat
execute if score @s test.settings.battle_ui matches 2 run function test:battle/ui/item
