scoreboard players operation #damage test.fire_damage = @s test.fire_damage
scoreboard players operation #damage test.water_damage = @s test.water_damage
scoreboard players operation #damage test.wood_damage = @s test.wood_damage
scoreboard players operation #damage test.metal_damage = @s test.metal_damage
scoreboard players operation #damage test.earth_damage = @s test.earth_damage
scoreboard players operation #damage test.physics_damage = @s test.physics_damage

scoreboard players operation #damage test.status.crit_rate = @s test.status.crit_rate
scoreboard players operation #damage test.status.crit_damage = @s test.status.crit_damage
scoreboard players operation #damage test.def.pene = @s test.def.pene

# ダメージ表示で詠唱者を引けるよう、覚えておいたOhMyDatIDから詠唱者に一時タグを付ける。
# 着弾イベントはこの後どこでも起きうるので、ダメージ量の設定と合わせて先に済ませておく
scoreboard players operation #owner test.temporary = @s test.owner
execute as @a if score @s OhMyDatID = #owner test.temporary run tag @s add damage_attacker

# 射程が尽きた(expire)。既定では静かに消えるが、タイプ側で処理を差し込める
execute if score @s test.time = @s test.range run function test:projectile/event {event:"expire"}
execute if score @s test.time = @s test.range if score #event_result test.temporary matches 0 run function test:projectile/kill
execute if score @s test.time = @s test.range if score #event_result test.temporary matches 2 run function test:projectile/kill

execute store result score @s test.X0 run data get entity @s Pos[0] 100
execute store result score @s test.Y0 run data get entity @s Pos[1] 100
execute store result score @s test.Z0 run data get entity @s Pos[2] 100

execute if score @s test.X1 matches -2147483648..2147483647 run scoreboard players operation @s test.X1 -= @s test.X0
execute if score @s test.Y1 matches -2147483648..2147483647 run scoreboard players operation @s test.Y1 -= @s test.Y0
execute if score @s test.Z1 matches -2147483648..2147483647 run scoreboard players operation @s test.Z1 -= @s test.Z0

execute unless score @s test.X1 matches -2147483648..2147483647 run scoreboard players set @s test.X1 0
execute unless score @s test.Y1 matches -2147483648..2147483647 run scoreboard players set @s test.Y1 0
execute unless score @s test.Z1 matches -2147483648..2147483647 run scoreboard players set @s test.Z1 0

execute unless score @s test.X1 matches -10..10 run tag @s add block_X
execute unless score @s test.Y1 matches -10..10 run tag @s add block_Y
execute unless score @s test.Z1 matches -10..10 run tag @s add block_Z

execute unless score @s test.X1 matches -10..10 run tag @s add block
execute unless score @s test.Y1 matches -10..10 run tag @s add block
execute unless score @s test.Z1 matches -10..10 run tag @s add block

scoreboard players operation @s test.X0 *= @s test.speed
scoreboard players operation @s test.Y0 *= @s test.speed
scoreboard players operation @s test.Z0 *= @s test.speed

scoreboard players operation @s test.X0 /= #100 test.constant
scoreboard players operation @s test.Y0 /= #100 test.constant
scoreboard players operation @s test.Z0 /= #100 test.constant

# 壁・地面に阻まれた(hit_block)。既定では跳ね返るが、タイプ側で処理を差し込める。
# 反射はこのタイミングでないと今tickの移動計算に反映されないため、判定位置はここから動かさない
execute if entity @s[tag=block] run function test:projectile/event {event:"hit_block"}
execute if entity @s[tag=block] if score #event_result test.temporary matches 0 run function test:projectile/reflect
execute if entity @s[tag=block] if score #event_result test.temporary matches 2 run function test:projectile/kill

execute at @s run summon area_effect_cloud ^ ^ ^1.0 {Tags:[mark],Radius:0,WaitTime:0}

execute if entity @s[tag=gravity] run function test:projectile/gravity

execute store result score @s test.X1 run data get entity @n[tag=mark] Pos[0] 100
execute store result score @s test.Y1 run data get entity @n[tag=mark] Pos[1] 100
execute store result score @s test.Z1 run data get entity @n[tag=mark] Pos[2] 100

scoreboard players operation @s test.X1 *= @s test.speed
scoreboard players operation @s test.Y1 *= @s test.speed
scoreboard players operation @s test.Z1 *= @s test.speed

scoreboard players operation @s test.X1 /= #100 test.constant
scoreboard players operation @s test.Y1 /= #100 test.constant
scoreboard players operation @s test.Z1 /= #100 test.constant

execute if entity @s[tag=block_X] run scoreboard players set @s test.gravity_time 0

scoreboard players operation @s test.X0 -= @s test.X1
scoreboard players operation @s test.Y0 -= @s test.Y1
scoreboard players operation @s test.Z0 -= @s test.Z1

execute store result entity @s Motion[0] double -0.01 run scoreboard players get @s test.X0
execute store result entity @s Motion[1] double -0.01 run scoreboard players get @s test.Y0
execute store result entity @s Motion[2] double -0.01 run scoreboard players get @s test.Z0

scoreboard players operation @s test.X1 += @s test.X0
scoreboard players operation @s test.Y1 += @s test.Y0
scoreboard players operation @s test.Z1 += @s test.Z0

scoreboard players operation @s test.X1 *= #100 test.constant
scoreboard players operation @s test.Y1 *= #100 test.constant
scoreboard players operation @s test.Z1 *= #100 test.constant

scoreboard players operation @s test.X1 /= @s test.speed
scoreboard players operation @s test.Y1 /= @s test.speed
scoreboard players operation @s test.Z1 /= @s test.speed

scoreboard players operation @s test.X1 -= @s test.X0
scoreboard players operation @s test.Y1 -= @s test.Y0
scoreboard players operation @s test.Z1 -= @s test.Z0

tag @s remove block
tag @s remove block_X
tag @s remove block_Y
tag @s remove block_Z

kill @n[tag=mark]

execute at @s run particle end_rod ~ ~ ~ 0 0 0 0 0

# HPを持つ対象のヒットボックスに触れたか(hit_entity)。詠唱者を含むプレイヤーには反応しない
# (プレイヤーを除外しないと、撃った直後に自分へ反応して暴発する)
scoreboard players set #hit_entity test.temporary 0
execute as @e[type=!player,tag=!projectile,scores={test.status.hp=1..},dx=-0.25,dy=-0.25,dz=-0.25] positioned ~-1 ~-1 ~-1 if entity @s[dx=0.25,dy=0.25,dz=0.25] run scoreboard players set #hit_entity test.temporary 1

execute if score #hit_entity test.temporary matches 1 run function test:projectile/event {event:"hit_entity"}

# 既定では触れた対象へ直接効果を与える(タイプ側で処理した場合はそちらにまかせる)
# バフの振り分けは@sがまだ投射体のうちに済ませておく(magic/hitの中では@sが対象に変わっているため)
execute if score #hit_entity test.temporary matches 1 if score #event_result test.temporary matches 0 run function test:projectile/prepare_buff
execute if score #hit_entity test.temporary matches 1 if score #event_result test.temporary matches 0 as @e[tag=!projectile,dx=-0.25,dy=-0.25,dz=-0.25] positioned ~-1 ~-1 ~-1 if entity @s[dx=0.25,dy=0.25,dz=0.25] run function test:magic/hit
execute if score #hit_entity test.temporary matches 1 if score #event_result test.temporary matches 2 run function test:projectile/kill

tag @a remove damage_attacker
