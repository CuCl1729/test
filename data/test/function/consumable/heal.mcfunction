#> test:consumable/heal
# @s = 回復する人。@macro stat: "hp" か "mp" / percent: 最大値の何%か / flat: 固定の量(装備の説明文と同じ単位)。
# 回復量 = 最大値 × percent ÷ 100 + flat × 100(HP・MPのスコアは装備の説明文の値の×100で持っているため)。
# 最大値を超えた分は切る(status/regene/hpと同じ)。回復の種類を増やすときは、ここに引数を足して1か所で計算する

$scoreboard players operation #heal_amount test.temporary = @s test.status.$(stat)_max
$scoreboard players set #heal_rate test.temporary $(percent)
scoreboard players operation #heal_amount test.temporary *= #heal_rate test.temporary
scoreboard players operation #heal_amount test.temporary /= #100 test.constant

$scoreboard players set #heal_flat test.temporary $(flat)
scoreboard players operation #heal_flat test.temporary *= #100 test.constant
scoreboard players operation #heal_amount test.temporary += #heal_flat test.temporary

$scoreboard players operation @s test.status.$(stat) += #heal_amount test.temporary
$execute if score @s test.status.$(stat) > @s test.status.$(stat)_max run scoreboard players operation @s test.status.$(stat) = @s test.status.$(stat)_max
