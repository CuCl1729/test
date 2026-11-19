#> test:battle/action/job_skill/magic/projectile
# @s = 詠唱者(手番)。@macro job/node: 発動した職業スキル参照(レシピはここでは持たない。
# 対象決定後にtest:battle/action/job_skill/magic/resolveがtest:job/skill/magic/prepareで都度作り直す)。
# test:battle/action/job_skill/handler/magicから、投射タイプ単体(範囲と組み合わせていない)のときだけ呼ばれる。
# 対象を選ぶ間は支払わず、通常攻撃と同じ対象選択UIを間借りする

function #oh_my_dat:please
data remove storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.pending_magic
$data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.pending_magic set value {job:"$(job)",node:"$(node)"}

scoreboard players set @s test.battle.pending_target_action 3

# 同じ戦闘(アリーナ)の生存している敵だけを数える(他のアリーナの敵を巻き込まない)
scoreboard players operation #job_magic_battle test.battle.id = @s test.battle.id
scoreboard players set #enemy_count test.temporary 0
execute as @e[tag=battle_member,tag=enemy,distance=..64,scores={test.status.hp=1..}] if score @s test.battle.id = #job_magic_battle test.battle.id run scoreboard players add #enemy_count test.temporary 1

# ここで即return(手番終了中などに#enemy_countが変わっても後続の分岐へ落ちないようにする)
execute if score #enemy_count test.temporary matches 0 run return run function test:battle/action/no_target

execute if score #enemy_count test.temporary matches 1 as @e[tag=battle_member,tag=enemy,distance=..64,scores={test.status.hp=1..}] if score @s test.battle.id = #job_magic_battle test.battle.id run tag @s add battle_target
execute if score #enemy_count test.temporary matches 1 run return run function test:battle/action/job_skill/magic/resolve

scoreboard players set @s test.battle.target_max 1
execute if score @s test.settings.battle_ui matches 1 run function test:battle/ui/target_select
execute if score @s test.settings.battle_ui matches 2 run function test:battle/ui/target_minecart
