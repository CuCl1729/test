#> test:buff/on/interval/poison
# @s = バフ保持者。#buff_stacks test.buff.work にスタック数が入っている
# 「ステータス変更ではない中身」の例。1スタックにつきHPを2(内部値200)減らす
# ダメージ計算(防御・耐性)は通さず、固定値をそのまま削る毒として扱う

scoreboard players operation #poison test.buff.work = #buff_stacks test.buff.work
scoreboard players operation #poison test.buff.work *= #200 test.constant

scoreboard players operation @s test.status.hp -= #poison test.buff.work

execute at @s run particle happy_villager ~ ~1 ~ 0.3 0.5 0.3 0 8 force @a
execute at @s run playsound minecraft:entity.generic.hurt master @a ~ ~ ~ 1 0.6

execute if score @s test.status.hp matches ..0 if entity @s[tag=enemy] run tellraw @a ["",{selector:"@s"},{text:"は毒で倒れた",color:gold}]
execute if score @s test.status.hp matches ..0 run function test:damage/kill
