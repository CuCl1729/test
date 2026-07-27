#> test:battle/setup
# @s = 戦闘のきっかけとなったエンティティ(ターン制マップ側)
# $(arena)=使用エリア番号 $(x)(y)(z)=そのエリアの座標
function test:debug/log {msg:"battle setup"}

$scoreboard players operation #arena_$(arena) test.arena.occupied = #battle test.battle.next_id

# 入り口マーカー(ターン制マップに残る。乱入時はこれを攻撃する)
summon marker ~ ~ ~ {Tags:[battle_entrance]}
scoreboard players operation @e[tag=battle_entrance,sort=nearest,limit=1] test.battle.id = #battle test.battle.next_id
$scoreboard players set @e[tag=battle_entrance,sort=nearest,limit=1] test.battle.arena $(arena)

# エリア側マーカー(実際のターン管理はこちら)
$execute positioned $(x) $(y) $(z) in test:arena run function test:battle/setup_arena_marker

function test:battle/join
execute as @a[distance=..8] at @s unless score @s test.battle.id matches 1.. run function test:battle/join
execute as @e[tag=enemy,distance=..8] at @s unless score @s test.battle.id matches 1.. run function test:battle/join

scoreboard players set #battle_weather test.temporary 0
execute if predicate test:weather/rain run scoreboard players set #battle_weather test.temporary 1
execute if predicate test:weather/thunder run scoreboard players set #battle_weather test.temporary 2

execute in test:arena run function test:battle/apply_weather

# チャンク座標を算出
execute store result score #chunk_x test.temporary run data get entity @s Pos[0] 1
execute store result score #chunk_z test.temporary run data get entity @s Pos[2] 1
scoreboard players operation #chunk_x test.temporary /= #16 test.constant
scoreboard players operation #chunk_z test.temporary /= #16 test.constant

$data modify storage test: battle.temporary.x set value $(x)
$data modify storage test: battle.temporary.y set value $(y)
$data modify storage test: battle.temporary.z set value $(z)

# まず汎用構造物を配置(必ず成功する)
execute in test:arena run function test:battle/place_default with storage test: battle.temporary

# 該当するゾーンがあれば専用構造物で上書き
execute in test:arena run function #test:battle_zones