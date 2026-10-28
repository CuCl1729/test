#> test:battle/turn_timer_tick
# @s = 戦闘マーカー(at @s)。プレイヤーの手番の残り時間(test.battle.turn_timer、tick単位)を進める。
# turn_start_playerが asset.config.turn_time 秒(「定数」タブ)を入れ、turn_endが0に戻す。
# - 手番の人がいない(ログアウトした・アリーナから離れた)ときは、待たずに手番を飛ばす
# - 残り asset.config.turn_warn 秒で本人に予告し、0になったら自動で防御させる

scoreboard players operation #turn_timer test.battle.id = @s test.battle.id
scoreboard players operation #turn_timer test.battle.current_turn = @s test.battle.current_turn

scoreboard players set #turn_actor_here test.temporary 0
execute as @a[tag=battle_member,distance=..64] if score @s test.battle.id = #turn_timer test.battle.id if score @s test.battle.turn_order = #turn_timer test.battle.current_turn run scoreboard players set #turn_actor_here test.temporary 1
execute if score #turn_actor_here test.temporary matches 0 run return run function test:battle/turn_skip

scoreboard players remove @s test.battle.turn_timer 1

# 残り asset.config.turn_warn 秒(「定数」タブ)で本人に予告する
execute store result score #turn_warn_sec test.temporary run data get storage test: asset.config.turn_warn
execute store result score #turn_warn test.temporary run data get storage test: asset.config.turn_warn 20
execute if score #turn_warn test.temporary matches 1.. if score @s test.battle.turn_timer = #turn_warn test.temporary as @a[tag=battle_member,distance=..64] if score @s test.battle.id = #turn_timer test.battle.id if score @s test.battle.turn_order = #turn_timer test.battle.current_turn run tellraw @s [{text:"あと",color:yellow},{score:{name:"#turn_warn_sec",objective:"test.temporary"},color:yellow},{text:"秒で、自動的に防御します",color:yellow}]
execute if score @s test.battle.turn_timer matches ..0 as @a[tag=battle_member,distance=..64] if score @s test.battle.id = #turn_timer test.battle.id if score @s test.battle.turn_order = #turn_timer test.battle.current_turn at @s run function test:battle/turn_timeout
