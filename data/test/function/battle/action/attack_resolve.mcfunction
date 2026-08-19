#> test:battle/action/attack_resolve
# @s = 攻撃者。@e[tag=battle_target] = 決定済みの対象(1体)。同じ戦闘エリア内の対象へ物理ダメージを与える
# 簡易実装: test.status.atk をそのまま物理ダメージ量として扱う（武器固有の倍率は今後のクラフト実装で拡張予定）

# アイテム式UIは行動アイテムを右クリックする都合上メインハンドが一時的に入れ替わるため、
# ここで再計算するとメインハンド武器の補正が失われる。アイテム式は行動アイテムを配る前(test:battle/ui/item)に
# 計算済みの値を使い、装備を動かさないチャット式のみここで再計算する。
execute if entity @s[type=player] if score @s test.settings.battle_ui matches 1 run function test:status/update {status:"atk"}

scoreboard players set #damage test.fire_damage 0
scoreboard players set #damage test.water_damage 0
scoreboard players set #damage test.wood_damage 0
scoreboard players set #damage test.metal_damage 0
scoreboard players set #damage test.earth_damage 0

scoreboard players operation #damage test.physics_damage = @s test.status.atk
scoreboard players operation #damage test.physics_damage *= @s test.physics_damage.bonus
scoreboard players operation #damage test.physics_damage /= #100 test.constant

scoreboard players set #damage test.def.pene 0
scoreboard players operation #damage test.def.pene = @s test.def.pene
scoreboard players set #damage test.physics_resist.pene 0
scoreboard players operation #damage test.physics_resist.pene = @s test.physics_resist.pene

scoreboard players operation #damage test.status.crit_rate = @s test.status.crit_rate
scoreboard players operation #damage test.status.crit_damage = @s test.status.crit_damage
scoreboard players operation #damage test.status.crit_damage /= #100 test.constant

# 範囲攻撃剣の場合、範囲攻撃専用倍率を追加で掛ける(通常攻撃はfire/water等が常に0のため無関係)
execute if score @s test.battle.weapon_aoe matches 1 run scoreboard players operation #damage test.physics_damage *= @s test.battle.weapon_aoe_multiplier
execute if score @s test.battle.weapon_aoe matches 1 run scoreboard players operation #damage test.physics_damage /= #100 test.constant

# 対象が複数(範囲攻撃)いる場合でもそれぞれ個別にダメージ計算・メッセージ表示するため、
# 攻撃者を一時タグで参照できるようにしてから対象ごとにループする
tag @s add battle_attacker

execute as @e[tag=battle_target] run function test:battle/action/attack_hit

tag @e remove battle_attacker
tag @e remove battle_target

function test:battle/turn_end
