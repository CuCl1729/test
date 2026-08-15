#> test:battle/turn_start_enemy
# @s = 現在手番の敵。AIの行動決定は今後ここに実装する（暫定でattackを実行してターンを進める）
# 即座に行動すると一瞬でターンが終わってしまうため、少し間を置いてから行動する

tellraw @a ["",{text:"敵のターン",color:red},{text:" ― 行動を選んでいます...",color:gray}]

scoreboard players set @e[tag=battle_marker,sort=nearest,limit=1] test.battle.enemy_delay 20
