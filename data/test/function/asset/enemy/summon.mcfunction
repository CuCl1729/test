$summon $(id) ~ ~ ~ {Tags:[summoned],Invulnerable:1b}


data modify entity @n[tag=summoned] Tags append from storage test: enemy.Tags[]
data modify entity @n[tag=summoned] data set from storage test: enemy.data

# 名前(テキストコンポーネントのコンパウンド。アイテムのcustom_nameコンポーネントと同じ形式)を
# 宣言していれば表示名として設定する(省略可。dummyは無名のまま)
execute if data storage test: enemy.name run data modify entity @n[tag=summoned] CustomName set from storage test: enemy.name
execute if data storage test: enemy.name run data modify entity @n[tag=summoned] CustomNameVisible set value 1b

scoreboard players operation @n[tag=summoned] test.status.atk = #enemy test.status.atk
scoreboard players operation @n[tag=summoned] test.status.crit_damage = #enemy test.status.crit_damage
scoreboard players operation @n[tag=summoned] test.status.crit_rate = #enemy test.status.crit_rate
scoreboard players operation @n[tag=summoned] test.status.def = #enemy test.status.def
scoreboard players operation @n[tag=summoned] test.status.divergence = #enemy test.status.divergence
scoreboard players operation @n[tag=summoned] test.status.effect_damage = #enemy test.status.effect_damage
scoreboard players operation @n[tag=summoned] test.status.hp_max = #enemy test.status.hp_max
scoreboard players operation @n[tag=summoned] test.status.hp = #enemy test.status.hp
scoreboard players operation @n[tag=summoned] test.status.magic_efficiency = #enemy test.status.magic_efficiency
scoreboard players operation @n[tag=summoned] test.status.mp_max = #enemy test.status.mp_max
scoreboard players operation @n[tag=summoned] test.status.mp = #enemy test.status.mp
scoreboard players operation @n[tag=summoned] test.status.exp = #enemy test.status.exp
scoreboard players operation @n[tag=summoned] test.def.debuff = #enemy test.def.debuff
scoreboard players operation @n[tag=summoned] test.def.coefficient = #enemy test.def.coefficient
scoreboard players operation @n[tag=summoned] test.def.pene = #enemy test.def.pene

# 敵は装備からステータスを組み立て直す status/update を通らないため、
# バフ/デバフを乗せ降ろしする土台として基礎値をそのまま控えておく(test:status/recalc が使う)
scoreboard players operation @n[tag=summoned] test.status.base.atk = #enemy test.status.atk
scoreboard players operation @n[tag=summoned] test.status.base.def = #enemy test.status.def
scoreboard players operation @n[tag=summoned] test.status.base.hp_max = #enemy test.status.hp_max
scoreboard players operation @n[tag=summoned] test.status.base.mp_max = #enemy test.status.mp_max
scoreboard players operation @n[tag=summoned] test.status.base.crit_rate = #enemy test.status.crit_rate
scoreboard players operation @n[tag=summoned] test.status.base.crit_damage = #enemy test.status.crit_damage
scoreboard players operation @n[tag=summoned] test.status.base.effect_damage = #enemy test.status.effect_damage
scoreboard players operation @n[tag=summoned] test.status.base.magic_efficiency = #enemy test.status.magic_efficiency
scoreboard players operation @n[tag=summoned] test.status.base.divergence = #enemy test.status.divergence

scoreboard players operation @n[tag=summoned] test.fire_resist = #enemy test.fire_resist
scoreboard players operation @n[tag=summoned] test.water_resist = #enemy test.water_resist
scoreboard players operation @n[tag=summoned] test.wood_resist = #enemy test.wood_resist
scoreboard players operation @n[tag=summoned] test.metal_resist = #enemy test.metal_resist
scoreboard players operation @n[tag=summoned] test.earth_resist = #enemy test.earth_resist
scoreboard players operation @n[tag=summoned] test.physics_resist = #enemy test.physics_resist

scoreboard players operation @n[tag=summoned] test.fire_damage_inc.bonus = #enemy test.fire_damage_inc.bonus
scoreboard players operation @n[tag=summoned] test.water_damage_inc.bonus = #enemy test.water_damage_inc.bonus
scoreboard players operation @n[tag=summoned] test.wood_damage_inc.bonus = #enemy test.wood_damage_inc.bonus
scoreboard players operation @n[tag=summoned] test.metal_damage_inc.bonus = #enemy test.metal_damage_inc.bonus
scoreboard players operation @n[tag=summoned] test.earth_damage_inc.bonus = #enemy test.earth_damage_inc.bonus
scoreboard players operation @n[tag=summoned] test.physics_damage_inc.bonus = #enemy test.physics_damage_inc.bonus

scoreboard players operation @n[tag=summoned] test.fire_damage.bonus = #enemy test.fire_damage.bonus
scoreboard players operation @n[tag=summoned] test.water_damage.bonus = #enemy test.water_damage.bonus
scoreboard players operation @n[tag=summoned] test.wood_damage.bonus = #enemy test.wood_damage.bonus
scoreboard players operation @n[tag=summoned] test.metal_damage.bonus = #enemy test.metal_damage.bonus
scoreboard players operation @n[tag=summoned] test.earth_damage.bonus = #enemy test.earth_damage.bonus
scoreboard players operation @n[tag=summoned] test.physics_damage.bonus = #enemy test.physics_damage.bonus

scoreboard players operation @n[tag=summoned] test.fire_resist.pene = #enemy test.fire_resist.pene
scoreboard players operation @n[tag=summoned] test.water_resist.pene = #enemy test.water_resist.pene
scoreboard players operation @n[tag=summoned] test.wood_resist.pene = #enemy test.wood_resist.pene
scoreboard players operation @n[tag=summoned] test.metal_resist.pene = #enemy test.metal_resist.pene
scoreboard players operation @n[tag=summoned] test.earth_resist.pene = #enemy test.earth_resist.pene
scoreboard players operation @n[tag=summoned] test.physics_resist.pene = #enemy test.physics_resist.pene

tag @n[tag=summoned] add enemy

# 頭上のHP表示をこの敵に騎乗させる(billboard:centerで向きの影響を受けず、translationで頭上へオフセット)
execute at @n[tag=summoned] run summon text_display ~ ~ ~ {Tags:[hp_display,hp_display_new],billboard:"center",transformation:{translation:[0.0f,0.3f,0.0f],scale:[1.0f,1.0f,1.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f]},text:{text:""},background:0}
ride @n[tag=hp_display_new] mount @n[tag=summoned]
tag @n[tag=hp_display_new] remove hp_display_new

tag @e[tag=summoned] remove summoned