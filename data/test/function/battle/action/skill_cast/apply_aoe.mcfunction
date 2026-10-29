#> test:battle/action/skill_cast/apply_aoe
# @s = 詠唱者。組み立て済みの magic.player を範囲で唱える。対象選択を挟まず、攻撃効果は敵全員へ、回復効果は
# 味方全員へ適用する(ターン制には実際の飛翔体が無いため、投射と組み合わせた場合もここへ来る)。
# 手番の行動(test:battle/action/skill_cast/aoe)と防具の自動発動(test:equip/proc/cast_battle)の両方で使う。手番は終えない

# 消費MP(反動・魔導掌握込み)はリアルタイムと同じ test:magic/pay で払う
scoreboard players set #skill_sufficient test.temporary 0
execute store result score #skill_sufficient test.temporary run function test:magic/pay
execute if score #skill_sufficient test.temporary matches 0 run return run tellraw @s [{text:"MPが足りません",color:gray}]

function test:battle/action/skill_cast/prepare_damage

# 選んだバフ/デバフを敵向け・味方向けに振り分けておく(配布はダメージ・回復の後)
data modify storage test: magic_buff.src set value []
execute if data storage test: magic.player.buff[0] run data modify storage test: magic_buff.src set from storage test: magic.player.buff
function test:magic/buff/prepare

# ダメージを与える魔法かどうかを見て表示を出し分ける。回復だけを選んだ場合に
# 「〇〇に0ダメージ！」を敵の数だけ出さないようにするため
scoreboard players set #has_damage test.temporary 0
execute unless score #damage test.fire_damage matches 0 run scoreboard players set #has_damage test.temporary 1
execute unless score #damage test.water_damage matches 0 run scoreboard players set #has_damage test.temporary 1
execute unless score #damage test.wood_damage matches 0 run scoreboard players set #has_damage test.temporary 1
execute unless score #damage test.metal_damage matches 0 run scoreboard players set #has_damage test.temporary 1
execute unless score #damage test.earth_damage matches 0 run scoreboard players set #has_damage test.temporary 1
execute unless score #damage test.physics_damage matches 0 run scoreboard players set #has_damage test.temporary 1

# 表示の出し分けはダメージの有無だけでなくデバフの有無も見る(毒だけを選んだ場合も攻撃扱いにする)。
# ダメージ計算のループ自体は#has_damageで絞ったままにしないと「0ダメージ！」が出てしまう
scoreboard players set #offensive test.temporary 0
execute if score #has_damage test.temporary matches 1 run scoreboard players set #offensive test.temporary 1
execute if data storage test: magic_buff.debuff[0] run scoreboard players set #offensive test.temporary 1

execute if score #offensive test.temporary matches 1 run tellraw @a[distance=..64] ["",{selector:"@s"},{text:" の範囲魔法！",color:light_purple}]
execute if score #offensive test.temporary matches 0 run tellraw @a[distance=..64] ["",{selector:"@s"},{text:" は味方全体に魔法を唱えた",color:light_purple}]

# 攻撃効果は生存している敵全員へ(詠唱者は一時タグで参照する)
tag @s add battle_caster
execute if score #has_damage test.temporary matches 1 at @s as @e[tag=battle_member,tag=enemy,distance=..64,scores={test.status.hp=1..}] run function test:battle/action/skill_cast/magic_hit
tag @e remove battle_caster

# 回復効果は生存している味方全員へ(対象ごとに回復量を表示する)
execute if data storage test: magic.player.heal at @s as @a[tag=battle_member,distance=..64,scores={test.status.hp=1..}] run function test:battle/action/skill_cast/heal_target

# デバフは生存している敵全員へ、バフは生存している味方全員へ配る
execute if data storage test: magic_buff.debuff[0] run data modify storage test: buff_work.pending set from storage test: magic_buff.debuff
execute if data storage test: magic_buff.debuff[0] at @s as @e[tag=battle_member,tag=enemy,distance=..64,scores={test.status.hp=1..}] run function test:buff/apply_list

execute if data storage test: magic_buff.buff[0] run data modify storage test: buff_work.pending set from storage test: magic_buff.buff
execute if data storage test: magic_buff.buff[0] at @s as @a[tag=battle_member,distance=..64,scores={test.status.hp=1..}] run function test:buff/apply_list

# 蘇生は、回復とバフを配った後に、同じ戦闘で倒れている味方全員へ(起きた人にこの魔法の回復やバフは掛からない)
scoreboard players operation #revive_battle test.battle.id = @s test.battle.id
execute if data storage test: magic.player.revive at @s as @a[tag=battle_member,scores={test.status.hp=..0}] if score @s test.battle.id = #revive_battle test.battle.id run function test:status/revive with storage test: magic.player.revive

