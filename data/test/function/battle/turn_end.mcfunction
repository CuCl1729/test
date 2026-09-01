#> test:battle/turn_end
# @s = 行動を終えたエンティティ

# ターン制ではバフ/デバフの継続時間を時間経過で減らさず、保持者の手番が終わるたびに10秒ぶん進める
# (バフは常に「秒」で持っているので、これだけで「継続時間(秒)/10 ターン」になる)。
# HPが0の実行者でturn_endが呼ばれる経路(turn_start_actor)があるため、そこでは進めない
execute if entity @s[tag=buffed] unless score @s test.status.hp matches ..0 run scoreboard players set #buff_step test.buff.work 10
execute if entity @s[tag=buffed] unless score @s test.status.hp matches ..0 run function test:buff/step

scoreboard players add @e[tag=battle_marker,sort=nearest,limit=1] test.battle.current_turn 1
execute if score @e[tag=battle_marker,sort=nearest,limit=1] test.battle.current_turn > @e[tag=battle_marker,sort=nearest,limit=1] test.battle.member_count run scoreboard players set @e[tag=battle_marker,sort=nearest,limit=1] test.battle.current_turn 1

scoreboard players set @e[tag=battle_marker,sort=nearest,limit=1] test.battle.acting 0
execute at @s run function test:battle/check_end