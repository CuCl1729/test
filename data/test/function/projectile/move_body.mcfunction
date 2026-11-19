# 片付け済み(owner/rejoinなどがこのtick中に既にkillタグを付けた)なら、tick終わりの除去より先に動いたり撃ったりしない
execute if entity @s[tag=kill] run return 0

execute if entity @s[tag=periodic] unless function test:magic/owner/find run return run function test:projectile/kill
tag @a remove magic_owner

scoreboard players operation #damage test.fire_damage = @s test.fire_damage
scoreboard players operation #damage test.water_damage = @s test.water_damage
scoreboard players operation #damage test.wood_damage = @s test.wood_damage
scoreboard players operation #damage test.metal_damage = @s test.metal_damage
scoreboard players operation #damage test.earth_damage = @s test.earth_damage
scoreboard players operation #damage test.physics_damage = @s test.physics_damage

scoreboard players operation #damage test.fire_resist.pene = @s test.fire_resist.pene
scoreboard players operation #damage test.water_resist.pene = @s test.water_resist.pene
scoreboard players operation #damage test.wood_resist.pene = @s test.wood_resist.pene
scoreboard players operation #damage test.metal_resist.pene = @s test.metal_resist.pene
scoreboard players operation #damage test.earth_resist.pene = @s test.earth_resist.pene
scoreboard players operation #damage test.physics_resist.pene = @s test.physics_resist.pene

scoreboard players operation #damage test.status.crit_rate = @s test.status.crit_rate
scoreboard players operation #damage test.status.crit_damage = @s test.status.crit_damage
scoreboard players operation #damage test.def.pene = @s test.def.pene

# 武器弾なら、発射時に凍結したaction(会心率/会心ダメージ/防御貫通/属性耐性貫通とattack.player)を
# action_hit として複製しておく。着弾は詠唱の数tick後になるため、現在のmagic.player.dataや
# 所持者の現在の武器(手替え後など)とは無関係に、発射時点の装備で命中させる
data remove storage test: action_hit
execute if data entity @s data.action run data modify storage test: action_hit set from entity @s data.action
execute if data storage test: action_hit{kind:"weapon"} run function test:action/weapon/load_hit

# ダメージ表示で詠唱者を引けるよう、覚えておいたOhMyDatIDから詠唱者に一時タグを付ける。
# 着弾イベントはこの後どこでも起きうるので、ダメージ量の設定と合わせて先に済ませておく
scoreboard players operation #owner test.temporary = @s test.owner
execute as @a if score @s OhMyDatID = #owner test.temporary run tag @s add damage_attacker

# 射程が尽きた(expire)。既定では静かに消えるが、タイプ側で処理を差し込める
execute if score @s test.time = @s test.range run function test:projectile/event {event:"expire"}
execute if score @s test.time = @s test.range if score #event_result test.temporary matches 0 run return run function test:projectile/kill
execute if score @s test.time = @s test.range if score #event_result test.temporary matches 2 run return run function test:projectile/kill

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
execute if entity @s[tag=block] if score #event_result test.temporary matches 2 run return run function test:projectile/kill

# 追尾(効果 homing)。この向きで進む前に、相手の方へ 1 tick ぶんだけ回る。
# 相手を覚えているので、より近い敵が現れても乗り換えない。相手が居なくなったら飛びながら選び直す。
# 重力はこの後の計算でそのまま掛かる(向きを変えるだけで、落下は止めない)
execute if data entity @s data.homing run function test:magic/homing/tick with entity @s data.homing

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

# 武器弾なら、HP対象と同じ二重AABBで乱入用マーカーにも接触させる。マーカーはダメージ対象ではないので
# magic/hitは呼ばない(下のHP判定がhp=0のマーカーを自然に除外する)が、接触自体は旧剣AoEと同じく
# 通常のhit_entityとして扱う
execute if data entity @s data.action{kind:"weapon"} as @e[type=!player,tag=!projectile,tag=battle_entrance,dx=-0.25,dy=-0.25,dz=-0.25] positioned ~-1 ~-1 ~-1 if entity @s[dx=0.25,dy=0.25,dz=0.25] run tag @s add weapon_hit
execute if data entity @s data.action{kind:"weapon"} as @e[type=!player,tag=!projectile,tag=battle_entrance,dx=-0.25,dy=-0.25,dz=-0.25] positioned ~-1 ~-1 ~-1 if entity @s[dx=0.25,dy=0.25,dz=0.25] run scoreboard players set #hit_entity test.temporary 1

execute if score #hit_entity test.temporary matches 1 run function test:projectile/event {event:"hit_entity"}

# 既定では触れた対象へ直接効果を与える(タイプ側で処理した場合はそちらにまかせる)
# バフの振り分けは@sがまだ投射体のうちに済ませておく(magic/hitの中では@sが対象に変わっているため)
execute if score #hit_entity test.temporary matches 1 if score #event_result test.temporary matches 0 run function test:projectile/prepare_buff
# 当てるのは命中判定と同じ「HPを持つプレイヤー以外」だけ(自分や味方、HP表示の文字やアイテムには当てない)
execute if score #hit_entity test.temporary matches 1 if score #event_result test.temporary matches 0 as @e[type=!player,tag=!projectile,scores={test.status.hp=1..},dx=-0.25,dy=-0.25,dz=-0.25] positioned ~-1 ~-1 ~-1 if entity @s[dx=0.25,dy=0.25,dz=0.25] run function test:magic/hit
execute if score #hit_entity test.temporary matches 1 if score #event_result test.temporary matches 2 run return run function test:projectile/kill

tag @a remove damage_attacker

# 一定間隔(つなぎ): 飛びながら、間隔ごとに今の位置で次の段を始める。弾はそのまま飛び続ける
execute if entity @s[tag=periodic] run scoreboard players remove @s test.device.timer 1
execute if entity @s[tag=periodic] if score @s test.device.timer matches ..0 run function test:magic/periodic/fire_timer
