#> test:status/downed_start
# @s = HPが0になったプレイヤー(アクション側)

tag @s add downed
scoreboard players set @s test.status.downed_timer 200

# 掛かっているバフ/デバフを全部外す。終了イベントを正しく通すことで、
# ステータス増減の蓄積値(test.buff.*)もきちんと戻る
function test:buff/clear {reason:"death"}

effect give @s minecraft:blindness 10 0 true
effect give @s minecraft:slowness 10 255 true
effect give @s minecraft:weakness 10 255 true