#> test:battle/turn_start_enemy
# @s = 現在手番の敵。行動は少し待ってから test:battle/enemy_delay_resolve → test:battle/enemy_ai/decide で決める
# 即座に行動すると一瞬でターンが終わってしまうため、少し間を置いてから行動する

tellraw @a[distance=..64] ["",{text:"敵のターン",color:red},{text:" ― 行動を選んでいます...",color:gray}]

execute store result score @e[tag=battle_marker,sort=nearest,limit=1] test.battle.enemy_delay run data get storage test: asset.config.enemy_delay
