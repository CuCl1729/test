#> test:status/revive
# @s = 倒れたプレイヤー。@macro percent: 戻すHP(最大HPの何%。最低1)。HPを戻して起こす。
# ターン制では HP が1以上になれば次から手番が回ってくる。リアルタイムではダウン(downed)も終える。
# 起こしたら1、倒れていなければ0を返す(蘇生の消耗品・魔法・職業スキルで共通)

execute if score @s test.status.hp matches 1.. run return 0

scoreboard players set @s test.status.hp 0
$function test:consumable/heal {stat:"hp",percent:$(percent),flat:0}
execute unless score @s test.status.hp matches 1.. run scoreboard players set @s test.status.hp 100

execute if entity @s[tag=downed] run function test:status/downed_end_revived
execute at @s run tellraw @a[distance=..64] ["",{selector:"@s"},{text:" が復活した！",color:green}]
return 1
