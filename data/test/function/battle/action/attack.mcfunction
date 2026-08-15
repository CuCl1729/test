#> test:battle/action/attack
# @s = 行動を選んだ攻撃者。同じ戦闘エリア内の生存している相手陣営を1体選び、物理ダメージを与える。
# 簡易実装: test.status.atk をそのまま物理ダメージ量として扱う（武器固有の倍率は今後のクラフト実装で拡張予定）

execute if entity @s[type=player] as @e[tag=battle_member,tag=enemy,distance=..64,scores={test.status.hp=1..},sort=nearest,limit=1] run tag @s add hit
execute unless entity @s[type=player] as @a[tag=battle_member,distance=..64,scores={test.status.hp=1..},sort=nearest,limit=1] run tag @s add hit

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

execute as @e[tag=hit] run function test:damage/

# 与えたダメージ量を集計してチャットに表示する
execute if entity @e[tag=hit] run scoreboard players set #total_damage test.temporary 0
execute if entity @e[tag=hit] run scoreboard players operation #total_damage test.temporary += #victim test.fire_damage
execute if entity @e[tag=hit] run scoreboard players operation #total_damage test.temporary += #victim test.water_damage
execute if entity @e[tag=hit] run scoreboard players operation #total_damage test.temporary += #victim test.wood_damage
execute if entity @e[tag=hit] run scoreboard players operation #total_damage test.temporary += #victim test.metal_damage
execute if entity @e[tag=hit] run scoreboard players operation #total_damage test.temporary += #victim test.earth_damage
execute if entity @e[tag=hit] run scoreboard players operation #total_damage test.temporary += #victim test.physics_damage

execute if entity @e[tag=hit] run tellraw @a ["",{selector:"@s"},{text:" の攻撃！ ",color:gray},{selector:"@e[tag=hit,limit=1]"},{text:" に",color:gray},{score:{name:"#total_damage",objective:"test.temporary"},color:red},{text:"ダメージ！",color:gray}]

tag @e remove hit

function test:battle/turn_end
