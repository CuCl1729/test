#> test:magic/field/inside_one
# @s = 場の中に居る者。通し番号を振って inside に積み、この場がまだ掛けていなければ掛ける
execute unless score @s test.magic.eid matches 1.. run scoreboard players add #eid test.time 1
execute unless score @s test.magic.eid matches 1.. run scoreboard players operation @s test.magic.eid = #eid test.time

execute store result storage test: field_work.one.e int 1 run scoreboard players get @s test.magic.eid
data modify storage test: field_work.inside append from storage test: field_work.one

# 敵にはデバフ、プレイヤーには支援のバフ(範囲魔法の振り分けと同じ)
data modify storage test: field_work.pending set value []
execute if entity @s[type=player] run data modify storage test: field_work.pending set from storage test: field_work.buff
execute if entity @s[type=!player] run data modify storage test: field_work.pending set from storage test: field_work.debuff

function test:magic/field/enter_check with storage test: field_work.one
