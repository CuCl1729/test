#> test:init/asset/status/defense
# @s = プレイヤー。被ダメージ計算(test:damage/・damage/apply_type)が防御側として読む値の初期値。
# 敵はasset/enemy/<name>が宣言するが、プレイヤーには以前これが無く、def.coefficientが未設定(0)のため
# 通過倍率が常に0%になり、敵の攻撃が必ず0ダメージになっていた。
# 初回はtest:init/asset/status/vanillaから、既存のプレイヤーにはtest:status/regene/から一度だけ呼ばれる

# 敵の基準値(asset/enemy/dummy)と同じ。生DEFがこの値と同じとき通過倍率50%
scoreboard players set @s test.def.coefficient 1000
scoreboard players set @s test.def.debuff 0

# 耐性0 = 属性ダメージをそのまま受ける
scoreboard players set @s test.fire_resist 0
scoreboard players set @s test.water_resist 0
scoreboard players set @s test.wood_resist 0
scoreboard players set @s test.metal_resist 0
scoreboard players set @s test.earth_resist 0
scoreboard players set @s test.physics_resist 0

scoreboard players set @s test.fire_resist.debuff 0
scoreboard players set @s test.water_resist.debuff 0
scoreboard players set @s test.wood_resist.debuff 0
scoreboard players set @s test.metal_resist.debuff 0
scoreboard players set @s test.earth_resist.debuff 0
scoreboard players set @s test.physics_resist.debuff 0

# 被ダメージ増加率(%)。100で増減なし
scoreboard players set @s test.fire_damage_inc.bonus 100
scoreboard players set @s test.water_damage_inc.bonus 100
scoreboard players set @s test.wood_damage_inc.bonus 100
scoreboard players set @s test.metal_damage_inc.bonus 100
scoreboard players set @s test.earth_damage_inc.bonus 100
scoreboard players set @s test.physics_damage_inc.bonus 100
