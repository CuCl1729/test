#> test:magic/beam/spawn
# @s = 持ち主(プレイヤー)。実行位置・向き = ビームの根元と向き。自動ビームを1本出す。
# 押し続ける入力が無いので有限の時間だけ出て、向きは出たときのまま(追尾なら毎 tick 相手の方へ回る)。
# 維持MPは取らない(起こされた段は無料)
scoreboard players operation #beam_owner test.temporary = @s OhMyDatID
scoreboard players set #beam_uid test.temporary 0
execute store result score #beam_uid test.temporary run data get storage test: magic.player.uid

# 同時に存在できる数の上限(つなぎ「一定間隔」の max_alive)。達していたら新しくは出さない
function test:magic/cont/cap
execute if score #cont_over test.temporary matches 1 run return 0
execute unless function test:magic/root/commit run return 0

summon armor_stand ~ ~ ~ {Tags:["magic_beam","beam_new"],Marker:1b,Invisible:1b,NoGravity:1b,Invulnerable:1b,Small:1b}

# summon は実行時の向きを引き継がない(26.3 で確認済み。Rotation は 0 0 のまま)。
# 向き(放射の基準角・追尾の狙い)を渡すため、向いている1ブロック先に目印を出してそこを向かせる。
# こうすると水平の向きだけでなく上下の向きもそのまま移る
summon marker ^ ^ ^1 {Tags:["beam_aim"]}
teleport @n[type=armor_stand,tag=beam_new] ~ ~ ~ facing entity @n[type=marker,tag=beam_aim] feet
kill @e[type=marker,tag=beam_aim]

function test:magic/beam/link/init
data modify entity @n[type=armor_stand,tag=beam_new] data.beam set from storage test: magic.player
# 自動ビームはdelay_ticksの対象外(スタート時から追う。相手は出た直後の最初のtickで選ばれる)
execute if data storage test: magic.player.homing run data modify entity @n[type=armor_stand,tag=beam_new] data.homing set from storage test: magic.player.homing
execute if data storage test: magic.player.homing run data modify entity @n[type=armor_stand,tag=beam_new] data.homing.delay_ticks set value 0

# 出た瞬間に相手を1回だけ選び、発射時刻を覚える(delay_ticks=0なのでtickで即座に向きを変え始める)
execute if data entity @n[type=armor_stand,tag=beam_new] data.homing store result score @n[type=armor_stand,tag=beam_new] test.homing.launch run time query gametime
execute if data entity @n[type=armor_stand,tag=beam_new] data.homing as @n[type=armor_stand,tag=beam_new] at @s run function test:magic/homing/acquire with entity @s data.homing

scoreboard players operation @n[type=armor_stand,tag=beam_new] test.owner = #beam_owner test.temporary
scoreboard players operation @n[type=armor_stand,tag=beam_new] test.magic_uid = #beam_uid test.temporary
execute store result score @n[type=armor_stand,tag=beam_new] test.device.life run data get storage test: magic.player.continuous.duration 20
scoreboard players set @n[type=armor_stand,tag=beam_new] test.device.timer 0

# ダメージは出たときの持ち主の値で固定する(弾と同じ。持ち主が居なくなっても最後まで同じ威力で出る)
scoreboard players operation @n[type=armor_stand,tag=beam_new] test.fire_damage = @s test.fire_damage
scoreboard players operation @n[type=armor_stand,tag=beam_new] test.water_damage = @s test.water_damage
scoreboard players operation @n[type=armor_stand,tag=beam_new] test.wood_damage = @s test.wood_damage
scoreboard players operation @n[type=armor_stand,tag=beam_new] test.metal_damage = @s test.metal_damage
scoreboard players operation @n[type=armor_stand,tag=beam_new] test.earth_damage = @s test.earth_damage
scoreboard players operation @n[type=armor_stand,tag=beam_new] test.physics_damage = @s test.physics_damage
scoreboard players operation @n[type=armor_stand,tag=beam_new] test.status.crit_rate = @s test.status.crit_rate
scoreboard players operation @n[type=armor_stand,tag=beam_new] test.status.crit_damage = @s test.status.crit_damage
scoreboard players operation @n[type=armor_stand,tag=beam_new] test.def.pene = @s test.def.pene
scoreboard players operation @n[type=armor_stand,tag=beam_new] test.fire_resist.pene = @s test.fire_resist.pene
scoreboard players operation @n[type=armor_stand,tag=beam_new] test.water_resist.pene = @s test.water_resist.pene
scoreboard players operation @n[type=armor_stand,tag=beam_new] test.wood_resist.pene = @s test.wood_resist.pene
scoreboard players operation @n[type=armor_stand,tag=beam_new] test.metal_resist.pene = @s test.metal_resist.pene
scoreboard players operation @n[type=armor_stand,tag=beam_new] test.earth_resist.pene = @s test.earth_resist.pene

# 発生源(設置物・飛んでいる弾・自分に付いて回る印)に乗せる。発生源が動けば根元も動き、
# 発生源が消えたらビームも終わる(test:magic/beam/auto_tick)
execute if entity @e[tag=chain_carrier] unless data storage test: magic.player.fixed_origin run tag @n[type=armor_stand,tag=beam_new] add beam_parented
execute if entity @e[tag=chain_carrier] unless data storage test: magic.player.fixed_origin run ride @n[type=armor_stand,tag=beam_new] mount @e[tag=chain_carrier,limit=1]

execute if data storage test: magic.player.root as @n[type=armor_stand,tag=beam_new] run function test:magic/root/retain with storage test: magic.player.root
tag @n[type=armor_stand,tag=beam_new] remove beam_new
