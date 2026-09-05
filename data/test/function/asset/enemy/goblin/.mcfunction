#> test:asset/enemy/goblin/
# 動いて戦う敵の実例。ステータスはバランス調整の基準であるdummyと同じ値にしてある
# (dummyとの違いは行動面だけにするため)。フィールドでは巡回・追跡し、接触すると
# 自分からバトルを仕掛ける(ai_field_enabled)。バトル中はHPが30%を切ると
# 「怒り」ギミック(自己強化して攻撃)を使うことがある(data.ai)

data remove storage test: enemy
data modify storage test: enemy.Tags set value [goblin]
data modify storage test: enemy.id set value armor_stand
data modify storage test: enemy.name set value {text:"ゴブリン",color:"dark_green"}
data modify storage test: enemy.data.loot_table set value "test:enemy/goblin"

data modify storage test: enemy.data.buff_on_hit set value [{id:"poison",stacks:1,chance:50}]

# フィールドで巡回・追跡し、プレイヤーに接触すると自分からバトルを仕掛ける
# (test:battle/field_ai/。test:tickがこのキーの有無を見て駆動するかどうかを決める)
data modify storage test: enemy.data.ai_field_enabled set value 1b

# 敵ターンAI(test:battle/enemy_ai/decide)が読む行動セット。防御は宣言しない(=戦闘が長引かない
# よう基本的に防御しない)。HPが30%を切ると「怒り」ギミック(自己強化して攻撃)を使うことがある
data modify storage test: enemy.data.ai set value {gimmicks:[{id:"enrage",weight:40,hp_below:30,cooldown:2}]}

scoreboard players set #enemy test.status.atk 100
scoreboard players set #enemy test.status.crit_damage 0
scoreboard players set #enemy test.status.crit_rate 0
scoreboard players set #enemy test.status.def 1000
scoreboard players set #enemy test.status.divergence 0
scoreboard players set #enemy test.status.effect_damage 0

# 本来はtest.status.hpとtest.status.hp_maxには実数値を設定
 scoreboard players operation #enemy test.status.hp = #dummy test.status.hp
 scoreboard players operation #enemy test.status.hp_max = #dummy test.status.hp

scoreboard players set #enemy test.status.exp 0
scoreboard players set #enemy test.status.magic_efficiency 0
scoreboard players set #enemy test.status.mp 0
scoreboard players set #enemy test.status.mp_max 0
scoreboard players set #enemy test.def.coefficient 1000
scoreboard players set #enemy test.def.debuff 0

scoreboard players set #enemy test.fire_resist 20
scoreboard players set #enemy test.water_resist 20
scoreboard players set #enemy test.wood_resist 20
scoreboard players set #enemy test.metal_resist 20
scoreboard players set #enemy test.earth_resist 20
scoreboard players set #enemy test.physics_resist 20

scoreboard players set #enemy test.fire_damage_inc.bonus 100
scoreboard players set #enemy test.water_damage_inc.bonus 100
scoreboard players set #enemy test.wood_damage_inc.bonus 100
scoreboard players set #enemy test.metal_damage_inc.bonus 100
scoreboard players set #enemy test.earth_damage_inc.bonus 100
scoreboard players set #enemy test.physics_damage_inc.bonus 100

scoreboard players set #enemy test.fire_damage.bonus 100
scoreboard players set #enemy test.water_damage.bonus 100
scoreboard players set #enemy test.wood_damage.bonus 100
scoreboard players set #enemy test.metal_damage.bonus 100
scoreboard players set #enemy test.earth_damage.bonus 100
scoreboard players set #enemy test.physics_damage.bonus 100

scoreboard players set #enemy test.fire_resist.pene 0
scoreboard players set #enemy test.water_resist.pene 0
scoreboard players set #enemy test.wood_resist.pene 0
scoreboard players set #enemy test.metal_resist.pene 0
scoreboard players set #enemy test.earth_resist.pene 0
scoreboard players set #enemy test.physics_resist.pene 0

scoreboard players set #enemy test.def.pene 0
