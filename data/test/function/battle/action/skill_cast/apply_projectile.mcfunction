#> test:battle/action/skill_cast/apply_projectile
# @s = 詠唱者。@e[tag=battle_target] = 決定済みの対象(1体)。組み立て済みの magic.player で魔法ダメージを与え、
# 選んだデバフを付ける。手番の行動(projectile_resolve)と防具の自動発動(test:equip/proc/cast_battle)の両方で使う。
# 手番は終えず、対象のタグも外さない(呼び出し元が行う)

# 対象は同じ戦闘のものだけ(他のアリーナで選択中の敵を巻き込まない)
execute store result score #has_target test.temporary run function test:battle/target/exists
execute if score #has_target test.temporary matches 0 run return 0

# 消費MP(反動・魔導掌握込み)はリアルタイムと同じ test:magic/pay で払う
scoreboard players set #skill_sufficient test.temporary 0
execute store result score #skill_sufficient test.temporary run function test:magic/pay
execute if score #skill_sufficient test.temporary matches 0 run return run tellraw @s [{text:"MPが足りません",color:gray}]

function test:battle/action/skill_cast/prepare_damage

# 対象ごとにダメージ計算とメッセージ表示を行う(詠唱者は一時タグで参照する)
tag @s add battle_caster
scoreboard players operation #target_battle test.battle.id = @s test.battle.id
execute as @e[tag=battle_target] if score @s test.battle.id = #target_battle test.battle.id run function test:battle/action/skill_cast/magic_hit
tag @e remove battle_caster

# 選んだデバフを対象へ付与する(投射タイプは攻撃系の効果しか組み合わせられないため味方向けは出てこない)
data modify storage test: magic_buff.src set value []
execute if data storage test: magic.player.buff[0] run data modify storage test: magic_buff.src set from storage test: magic.player.buff
function test:magic/buff/prepare
execute if data storage test: magic_buff.debuff[0] run data modify storage test: buff_work.pending set from storage test: magic_buff.debuff
execute if data storage test: magic_buff.debuff[0] as @e[tag=battle_target,scores={test.status.hp=1..}] if score @s test.battle.id = #target_battle test.battle.id run function test:buff/apply_list
