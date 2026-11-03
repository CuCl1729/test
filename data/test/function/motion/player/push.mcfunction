#> test:motion/player/push
# @s = プレイヤー。#motion test.X0/Y0/Z0 = 与える速度(世界の向き。0.01 ブロック/tick 単位)。
# エンチャント test:move/add_impulse_{x,y,z} の apply_impulse で、次の tick に一度だけその速度を足す。
# apply_impulse の向きはプレイヤーの視点の向き(左 ^1 / 上 ^ ^1 / 前 ^ ^ ^1)なので、ここでその3成分に直して
# プレイヤーごとのスコア test.impulse.x/y/z に入れる(impulse/pre_* が読む。同じ tick に何人押しても混ざらない)。
# エンチャントを付ける saddle スロットには、プレイヤーでも入るよう equippable を付けた test_block を入れる
# (消滅の呪いで、死んでも落ちない)
execute unless items entity @s saddle minecraft:test_block run item replace entity @s saddle with minecraft:test_block[equippable={slot:"saddle"},enchantments={"minecraft:vanishing_curse":1}]

# 視点の向きの単位ベクトル(×1000)を、プレイヤーの位置に出した目印から求める(読み込まれた場所なので必ず出る)
execute at @s rotated as @s run summon marker ~ ~ ~ {Tags:["push_o"]}
execute at @s rotated as @s run summon marker ^1 ^ ^ {Tags:["push_l"]}
execute at @s rotated as @s run summon marker ^ ^1 ^ {Tags:["push_u"]}
execute at @s rotated as @s run summon marker ^ ^ ^1 {Tags:["push_f"]}
execute store result score #push_ox test.temporary run data get entity @n[type=marker,tag=push_o] Pos[0] 1000
execute store result score #push_oy test.temporary run data get entity @n[type=marker,tag=push_o] Pos[1] 1000
execute store result score #push_oz test.temporary run data get entity @n[type=marker,tag=push_o] Pos[2] 1000

function test:motion/player/push_axis {tag:"push_l",out:"test.impulse.x"}
function test:motion/player/push_axis {tag:"push_u",out:"test.impulse.y"}
function test:motion/player/push_axis {tag:"push_f",out:"test.impulse.z"}
kill @e[type=marker,tag=push_o]
kill @e[type=marker,tag=push_l]
kill @e[type=marker,tag=push_u]
kill @e[type=marker,tag=push_f]

scoreboard players set #power test.multiplier 1
item modify entity @s saddle test:move/add_impulse
