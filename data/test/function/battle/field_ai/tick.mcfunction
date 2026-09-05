#> test:battle/field_ai/tick
# @s = フィールド上の敵(戦闘参加前、test:tickから in test:turn as @e[tag=enemy,tag=!battle_member]
# unless score @s test.status.hp matches ..0 at @s で毎tick呼ばれる)。
# 近くに生存プレイヤーがいれば追跡、いなければ巡回する

execute if entity @p[distance=..8,tag=!downed] run function test:battle/field_ai/chase_step
execute unless entity @p[distance=..8,tag=!downed] run function test:battle/field_ai/wander_step
