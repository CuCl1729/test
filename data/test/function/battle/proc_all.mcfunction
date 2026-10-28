#> test:battle/proc_all
# @s = 手番を終える者(行動した者、または戦闘マーカー。at @s)。test:battle/turn_end が手番を進める前に呼ぶ。
# 行動の最中ではなく、行動が終わった直後に、この戦闘について次を行う(行動の作業用データを壊さないため)
# 1. 防具のしきい値(HP低下など)を見る。敵の攻撃や毒で減った分も、同じtickのうちに拾う
# 2. 予約された防具の自動発動を実行する(test:equip/proc/run。魔法は test:equip/proc/cast_battle で唱える)
# 3. 倒された敵の報酬を渡す(test:battle/grant_reward)。倒した敵はそのtickの終わりに消えるので、勝敗を決める前にここで渡す

scoreboard players operation #proc_battle test.battle.id = @s test.battle.id

execute as @a[tag=battle_member,distance=..64,scores={test.equip.has_watch=1}] if score @s test.battle.id = #proc_battle test.battle.id at @s run function test:equip/proc/watch_check
execute as @a[tag=battle_member,tag=equip_proc_queued,distance=..64] if score @s test.battle.id = #proc_battle test.battle.id at @s run function test:equip/proc/run
tag @e[tag=equip_proc_target,distance=..64] remove equip_proc_target

# 報酬はこの戦闘の参加者全員へ(倒れている人にも渡す)
execute as @a[tag=battle_member,distance=..64] if score @s test.battle.id = #proc_battle test.battle.id run tag @s add battle_reward_recipient
execute as @e[tag=battle_reward_pending,distance=..64] if score @s test.battle.id = #proc_battle test.battle.id run function test:battle/grant_reward
tag @a remove battle_reward_recipient
