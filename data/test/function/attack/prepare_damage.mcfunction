#> test:attack/prepare_damage
# @s = 攻撃者(プレイヤー)。storage test: attack.player(武器の custom_data)の damage から、通常攻撃のダメージを
# #damage に載せる。リアルタイムの test:attack/prepare と、ターン制の通常攻撃・剣のスキルで使う

function test:damage/pre_attack
function test:status/refresh {status:"crit_rate"}
function test:status/refresh {status:"crit_damage"}

scoreboard players operation #damage test.status.crit_rate = @s test.status.crit_rate

# 会心ダメージは15000=150%で持っている。damage/crit_applyには÷100した値(150)を渡す
# (プレイヤー自身のスコアは書き換えない。ステータス表示やターン制の計算がずれるため)
scoreboard players operation #damage test.status.crit_damage = @s test.status.crit_damage
scoreboard players operation #damage test.status.crit_damage /= #100 test.constant

scoreboard players operation #damage test.def.pene = @s test.def.pene

scoreboard players operation #damage test.fire_resist.pene = @s test.fire_resist.pene
scoreboard players operation #damage test.water_resist.pene = @s test.water_resist.pene
scoreboard players operation #damage test.wood_resist.pene = @s test.wood_resist.pene
scoreboard players operation #damage test.metal_resist.pene = @s test.metal_resist.pene
scoreboard players operation #damage test.earth_resist.pene = @s test.earth_resist.pene
scoreboard players operation #damage test.physics_resist.pene = @s test.physics_resist.pene

scoreboard players operation #damage test.fire_damage = @s test.fire_damage
scoreboard players operation #damage test.water_damage = @s test.water_damage
scoreboard players operation #damage test.wood_damage = @s test.wood_damage
scoreboard players operation #damage test.metal_damage = @s test.metal_damage
scoreboard players operation #damage test.earth_damage = @s test.earth_damage
scoreboard players operation #damage test.physics_damage = @s test.physics_damage
