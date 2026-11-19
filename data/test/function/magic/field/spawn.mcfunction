#> test:magic/field/spawn
# @s = 持ち主(プレイヤー)。実行位置 = 場を出す所。
# 有限の時間だけ残り、一定間隔で円状に効果を出す場を1つ置く。
# 場は「出した元」について動く: 直接唱えたときは持ち主、設置物から起きたときは設置物、
# 飛んでいる弾から起きたときはその弾(持ち主に勝手に付け替えたりはしない)
scoreboard players operation #field_owner test.temporary = @s OhMyDatID
scoreboard players set #field_uid test.temporary 0
execute store result score #field_uid test.temporary run data get storage test: magic.player.uid

# 同時に存在できる数の上限(つなぎ「一定間隔」の max_alive)。達していたら新しくは出さない
function test:magic/cont/cap
execute if score #cont_over test.temporary matches 1 run return 0
execute unless function test:magic/root/commit run return 0

summon armor_stand ~ ~ ~ {Tags:["magic_field","field_new"],Marker:1b,Invisible:1b,NoGravity:1b,Invulnerable:1b,Small:1b}

data modify entity @n[type=armor_stand,tag=field_new] data.field set from storage test: magic.player
data modify entity @n[type=armor_stand,tag=field_new] data.members set value []

scoreboard players operation @n[type=armor_stand,tag=field_new] test.owner = #field_owner test.temporary
scoreboard players operation @n[type=armor_stand,tag=field_new] test.magic_uid = #field_uid test.temporary

# この場だけを指す通し番号。掛けたバフを「この場のぶん」としてバフ側に持たせるのに使う
# (別の場が同じidのバフを掛けていても混ざらない)
scoreboard players add #eid test.time 1
scoreboard players operation @n[type=armor_stand,tag=field_new] test.magic.eid = #eid test.time
execute store result score @n[type=armor_stand,tag=field_new] test.device.life run data get storage test: magic.player.continuous.duration 20
scoreboard players set @n[type=armor_stand,tag=field_new] test.device.timer 0

# ダメージは出たときの持ち主の値で固定する(弾・自動ビームと同じ)
scoreboard players operation @n[type=armor_stand,tag=field_new] test.fire_damage = @s test.fire_damage
scoreboard players operation @n[type=armor_stand,tag=field_new] test.water_damage = @s test.water_damage
scoreboard players operation @n[type=armor_stand,tag=field_new] test.wood_damage = @s test.wood_damage
scoreboard players operation @n[type=armor_stand,tag=field_new] test.metal_damage = @s test.metal_damage
scoreboard players operation @n[type=armor_stand,tag=field_new] test.earth_damage = @s test.earth_damage
scoreboard players operation @n[type=armor_stand,tag=field_new] test.physics_damage = @s test.physics_damage
scoreboard players operation @n[type=armor_stand,tag=field_new] test.status.crit_rate = @s test.status.crit_rate
scoreboard players operation @n[type=armor_stand,tag=field_new] test.status.crit_damage = @s test.status.crit_damage
scoreboard players operation @n[type=armor_stand,tag=field_new] test.def.pene = @s test.def.pene
scoreboard players operation @n[type=armor_stand,tag=field_new] test.fire_resist.pene = @s test.fire_resist.pene
scoreboard players operation @n[type=armor_stand,tag=field_new] test.water_resist.pene = @s test.water_resist.pene
scoreboard players operation @n[type=armor_stand,tag=field_new] test.wood_resist.pene = @s test.wood_resist.pene
scoreboard players operation @n[type=armor_stand,tag=field_new] test.metal_resist.pene = @s test.metal_resist.pene
scoreboard players operation @n[type=armor_stand,tag=field_new] test.earth_resist.pene = @s test.earth_resist.pene

# 発生源に乗せる(設置物・弾・自分に付いて回る印)。無ければ持ち主について動く
execute if entity @e[tag=chain_carrier] unless data storage test: magic.player.fixed_origin run tag @n[type=armor_stand,tag=field_new] add field_parented
execute if entity @e[tag=chain_carrier] unless data storage test: magic.player.fixed_origin run ride @n[type=armor_stand,tag=field_new] mount @e[tag=chain_carrier,limit=1]
execute unless entity @e[tag=chain_carrier] unless data storage test: magic.player.fixed_origin run tag @n[type=armor_stand,tag=field_new] add field_follow_owner

execute if data storage test: magic.player.root as @n[type=armor_stand,tag=field_new] run function test:magic/root/retain with storage test: magic.player.root
tag @n[type=armor_stand,tag=field_new] remove field_new
