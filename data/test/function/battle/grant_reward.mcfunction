#> test:battle/grant_reward
# @s = 倒された敵。その敵の報酬(経験値・素材・装備・職業の経験値)を、battle_reward_recipient の付いた
# プレイヤー全員に渡す。ターン制では手番の終わり(test:battle/proc_all)に、戦闘の外では test:reward/field_kill から呼ぶ。
# 素材の個数と装備が落ちるかは、ここで敵1体につき1回だけ抽選する(全員に同じものを渡す。抽選はすべて rng/roll)。
# 受け取る人ごとの処理(test:battle/grant_reward_to_player)は、抽選結果を配るだけ

tag @s remove battle_reward_pending

execute store result score #reward test.temporary run scoreboard players get @s test.status.exp

# 前の敵の結果が残らないよう、先に空にする
data modify storage test: battle.temporary.material_hits set value []
data modify storage test: battle.temporary.equip_hits set value []
function test:item/material/roll_drops
function test:equip/drop/roll_all
function test:battle/drop_log

execute as @a[tag=battle_reward_recipient] run function test:battle/grant_reward_to_player
