scoreboard players operation #victim test.fire_damage = #damage test.fire_damage
scoreboard players operation #victim test.water_damage = #damage test.water_damage
scoreboard players operation #victim test.wood_damage = #damage test.wood_damage
scoreboard players operation #victim test.metal_damage = #damage test.metal_damage
scoreboard players operation #victim test.earth_damage = #damage test.earth_damage
scoreboard players operation #victim test.physics_damage = #damage test.physics_damage

# クリティカル判定。26.3でfloat providerの内部フィールド名がどうしても実機で確定できず
# (mul/from_intの引数名を2回試して2回ともパース失敗した)、predicateでの表現をやめて
# 同じ確率(crit_rateは1万分率)をrandom valueとの比較で直接判定する形にした
scoreboard players set #crit_roll test.temporary 0
execute store result score #crit_roll test.temporary run random value 1..10000
execute if score #crit_roll test.temporary <= #damage test.status.crit_rate run function test:damage/crit

# 防御係数計算
# ①合計貫通値    = 攻撃側def.pene + 防御側def.debuff
# ②有効貫通率(%) = 合計貫通値 × 100 ÷ (100 + 防御側def.coefficient)
#                  coefficientが高いほど、同じ貫通値でも有効貫通率は小さくなる(=貫通耐性)
# ③残存防御      = 生DEF × max(0, 100−有効貫通率) ÷ 100(貫通されるほど防御が目減りする。
#                  目減りの度合いはcoefficientで抑えられる)
# ④通過倍率      = coefficient × 100 ÷ (残存防御 + coefficient)
#                  生DEFが大きいほど下がる(=ダメージが減る)。有効貫通率が上がるほど
#                  残存防御が縮み、通過倍率はK/(a-bx)の形で加速度的に増える
#                  (=貫通・デバフは重ねるほど1%あたりの効果が大きくなる、他のバフと逆の性質)。
#                  coefficientは貫通値が0なら②が0になるため通過倍率に影響しない=
#                  「相手の貫通・デバフにどれだけ強いか」だけを表す
 scoreboard players set #pene_total test.temporary 0
 scoreboard players operation #pene_total test.temporary = #damage test.def.pene
 scoreboard players operation #pene_total test.temporary += @s test.def.debuff

 scoreboard players operation #victim test.def.coefficient = @s test.def.coefficient

 scoreboard players operation #effective_pene test.temporary = #pene_total test.temporary
 scoreboard players operation #effective_pene test.temporary *= #100 test.constant
 scoreboard players operation #victim test.temporary = #victim test.def.coefficient
 scoreboard players operation #victim test.temporary += #100 test.constant
 scoreboard players operation #effective_pene test.temporary /= #victim test.temporary
 execute if score #effective_pene test.temporary matches 100.. run scoreboard players set #effective_pene test.temporary 100

 scoreboard players operation #remaining_def test.temporary = @s test.status.def
 scoreboard players set #victim test.temporary 100
 scoreboard players operation #victim test.temporary -= #effective_pene test.temporary
 scoreboard players operation #remaining_def test.temporary *= #victim test.temporary
 scoreboard players operation #remaining_def test.temporary /= #100 test.constant

 scoreboard players operation #remaining_def test.temporary += #victim test.def.coefficient
 scoreboard players operation #victim test.status.def = #victim test.def.coefficient
 scoreboard players operation #victim test.status.def *= #100 test.constant
 scoreboard players operation #victim test.status.def /= #remaining_def test.temporary

# 属性ごとのダメージ処理
function test:damage/apply_type {type:"fire"}
function test:damage/apply_type {type:"water"}
function test:damage/apply_type {type:"wood"}
function test:damage/apply_type {type:"metal"}
function test:damage/apply_type {type:"earth"}
function test:damage/apply_type {type:"physics"}

execute if score @s test.status.hp matches ..0 run function test:damage/kill