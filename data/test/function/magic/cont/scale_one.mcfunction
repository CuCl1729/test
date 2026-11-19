#> test:magic/cont/scale_one
# @s = 持続物の本体。@macro ch: 属性の名前(fire / water / wood / metal / earth)。
# その属性のダメージを1パルスぶんに縮め、割り切れないぶんを本体に持ち越す
$execute unless score @s test.magic.frac.$(ch) matches -2147483648..2147483647 run scoreboard players set @s test.magic.frac.$(ch) 0

$scoreboard players operation #cont_v test.temporary = #damage test.$(ch)_damage
scoreboard players operation #cont_v test.temporary *= #cont_period test.temporary
$scoreboard players operation #cont_v test.temporary += @s test.magic.frac.$(ch)

$scoreboard players operation @s test.magic.frac.$(ch) = #cont_v test.temporary
$scoreboard players operation @s test.magic.frac.$(ch) %= #20 test.constant

scoreboard players operation #cont_v test.temporary /= #20 test.constant
$scoreboard players operation #damage test.$(ch)_damage = #cont_v test.temporary
