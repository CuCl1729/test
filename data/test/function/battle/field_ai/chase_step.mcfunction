#> test:battle/field_ai/chase_step
# @s = 追跡中の敵。近くの生存プレイヤー(@p[distance=..8])へ向き直り、近接まで来ていれば接触する。
# そうでなければ前進する

execute at @s facing entity @p[distance=..8,tag=!downed,limit=1,sort=nearest] feet run tp @s ~ ~ ~ ~ ~

# 近接距離まで来ていて、対象がまだ戦闘中でなければ接触してバトルを仕掛ける
execute if entity @p[distance=..1.5,tag=!battle_member,tag=!downed] unless score @s test.battle.id matches 1.. run function test:battle/field_ai/contact
execute if entity @p[distance=..1.5,tag=!battle_member,tag=!downed] unless score @s test.battle.id matches 1.. run return 0

function test:battle/field_ai/step_forward {dist:0.15}
