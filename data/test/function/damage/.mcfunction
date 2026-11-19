scoreboard players operation #victim test.fire_damage = #damage test.fire_damage
scoreboard players operation #victim test.water_damage = #damage test.water_damage
scoreboard players operation #victim test.wood_damage = #damage test.wood_damage
scoreboard players operation #victim test.metal_damage = #damage test.metal_damage
scoreboard players operation #victim test.earth_damage = #damage test.earth_damage
scoreboard players operation #victim test.physics_damage = #damage test.physics_damage

# クリティカル判定。crit_rateは1万分率なので、1..10000の抽選値が会心率以下なら発生
# (抽選はtest:rng/roll経由。デバッグメニューから固定・シードでの再現ができる)。
# #crit_hitはダメージログ(test:debug/trace/damage/result)用に結果を残しておくもの
scoreboard players set #crit_roll test.temporary 0
execute store result score #crit_roll test.temporary run function test:rng/roll {key:"crit",min:1,max:10000}
scoreboard players set #crit_hit test.temporary 0
execute if score #crit_roll test.temporary <= #damage test.status.crit_rate run scoreboard players set #crit_hit test.temporary 1
execute if score #crit_hit test.temporary matches 1 run function test:damage/crit

# 防御の通過倍率(test:damage/def_rate に計算の説明がある)
function test:damage/def_rate

# 属性ごとのダメージ処理
function test:damage/apply_type {type:"fire"}
function test:damage/apply_type {type:"water"}
function test:damage/apply_type {type:"wood"}
function test:damage/apply_type {type:"metal"}
function test:damage/apply_type {type:"earth"}
function test:damage/apply_type {type:"physics"}

execute if score #log_damage test.debug.enabled matches 1 run function test:debug/trace/damage/result

# ダメージを受けたプレイヤーの防具のセット効果(damaged)。倒れた場合は動かさない
execute if entity @s[type=player,scores={test.status.hp=1..}] run function test:equip/event {event:"damaged"}

execute if score @s test.status.hp matches ..0 run function test:damage/kill