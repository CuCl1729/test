#> test:battle/action/skill_cast/aoe
# @s = 詠唱者。範囲魔法は対象選択を挟まず、攻撃効果は敵全員へ、回復効果は味方全員へ適用する
# (ターン制には実際の飛翔体が無いため、投射と組み合わせた場合もここへ来る)

function #oh_my_dat:please
function test:battle/action/skill_cast/build

scoreboard players set #skill_sufficient test.temporary 0
execute if score @s test.status.mp >= #skill_cost test.temporary run scoreboard players set #skill_sufficient test.temporary 1

execute if score #skill_sufficient test.temporary matches 0 run tellraw @s [{text:"MPが足りません",color:gray}]
execute if score #skill_sufficient test.temporary matches 0 run return run function test:battle/turn_end

scoreboard players operation @s test.status.mp -= #skill_cost test.temporary

function test:battle/action/skill_cast/prepare_damage

tellraw @a ["",{selector:"@s"},{text:" の範囲魔法！",color:light_purple}]

# 攻撃効果は生存している敵全員へ(詠唱者は一時タグで参照する)
tag @s add battle_caster
execute at @s as @e[tag=battle_member,tag=enemy,distance=..64,scores={test.status.hp=1..}] run function test:battle/action/skill_cast/magic_hit
tag @e remove battle_caster

# 回復効果は生存している味方全員へ(magic/effect/healは@sを回復する再帰関数なので対象ごとにリセットする)
execute if data storage test: magic.player.heal at @s as @a[tag=battle_member,distance=..64,scores={test.status.hp=1..}] run scoreboard players reset @s test.repeat
execute if data storage test: magic.player.heal at @s as @a[tag=battle_member,distance=..64,scores={test.status.hp=1..}] run function test:magic/effect/heal

function test:battle/turn_end
