#> test:battle/action/attack_resolve
# @s = 攻撃者。@e[tag=battle_target] = 決定済みの対象(1体)。同じ戦闘エリア内の対象へダメージを与える
# プレイヤーはリアルタイムと同じく武器の damage(倍率・基礎値・属性)で計算する(test:battle/action/attack_damage_player)。
# 敵は武器を持たないので、攻撃力をそのまま物理ダメージにする

execute if entity @s[type=player] run function test:battle/action/attack_damage_player
execute unless entity @s[type=player] run function test:battle/action/attack_damage_enemy

# 対象が複数(範囲攻撃)いる場合でもそれぞれ個別にダメージ計算・メッセージ表示するため、
# 攻撃者を一時タグで参照できるようにしてから対象ごとにループする
tag @s add battle_attacker

# 対象は同じ戦闘のものだけ(他のアリーナで選択中の敵を巻き込まない)
scoreboard players operation #target_battle test.battle.id = @s test.battle.id
execute as @e[tag=battle_target] if score @s test.battle.id = #target_battle test.battle.id run function test:battle/action/attack_hit

tag @e remove battle_attacker
function test:battle/target/clear

function test:battle/turn_end
