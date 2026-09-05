#> test:battle/field_ai/wander_step
# @s = 巡回中の敵。data.ai_field.wander_timer が尽きたらランダムな向きへ向き直し、前進する
# (未設定なら0扱いになり、初回tickで自動的に向きが決まる。crafter_ui等と同じ自己修復的な初期化)

scoreboard players set #wander_timer test.buff.work 0
execute store result score #wander_timer test.buff.work run data get entity @s data.ai_field.wander_timer

execute if score #wander_timer test.buff.work matches ..0 run function test:battle/field_ai/wander_turn
execute if score #wander_timer test.buff.work matches 1.. run scoreboard players remove #wander_timer test.buff.work 1
execute if score #wander_timer test.buff.work matches 1.. store result entity @s data.ai_field.wander_timer int 1 run scoreboard players get #wander_timer test.buff.work

function test:battle/field_ai/step_forward {dist:0.1}
