#> test:battle/turn_end
# @s = 行動を終えたエンティティ

execute if score #log_battle test.debug.enabled matches 1 run function test:debug/trace/battle/turn_end

# ターン制ではバフ/デバフの継続時間を時間経過で減らさず、保持者の手番が終わるたびに10秒ぶん進める
# (バフは常に「秒」で持っているので、これだけで「継続時間(秒)/10 ターン」になる)。
# HPが0の実行者でturn_endが呼ばれる経路(turn_start_actor)があるため、そこでは進めない
execute if entity @s[tag=buffed] unless score @s test.status.hp matches ..0 run scoreboard players set #buff_step test.buff.work 10
execute if entity @s[tag=buffed] unless score @s test.status.hp matches ..0 run function test:buff/step

# 行動の直後に、防具の自動発動と倒した敵の報酬(勝敗を決める check_end より前)
execute at @s run function test:battle/proc_all

scoreboard players add @e[tag=battle_marker,sort=nearest,limit=1] test.battle.current_turn 1
execute if score @e[tag=battle_marker,sort=nearest,limit=1] test.battle.current_turn > @e[tag=battle_marker,sort=nearest,limit=1] test.battle.member_count run scoreboard players set @e[tag=battle_marker,sort=nearest,limit=1] test.battle.current_turn 1

# 手番の制限時間を止める(敵の手番でも acting は1なので、残っていると数え続けてしまう)
scoreboard players set @e[tag=battle_marker,sort=nearest,limit=1] test.battle.turn_timer 0
scoreboard players set @e[tag=battle_marker,sort=nearest,limit=1] test.battle.acting 0
execute at @s run function test:battle/check_end