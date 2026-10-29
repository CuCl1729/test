#> test:battle/action/attack_damage_enemy_element
# @s = 攻撃する敵。@macro element: 攻撃属性(physics/fire/water/wood/metal/earth)。攻撃力 × その属性の与ダメ倍率を
# #damage のその属性に入れ、その属性の耐性貫通も載せる

$scoreboard players operation #damage test.$(element)_damage = @s test.status.atk
$scoreboard players operation #damage test.$(element)_damage *= @s test.$(element)_damage.bonus
$scoreboard players operation #damage test.$(element)_damage /= #100 test.constant
$scoreboard players operation #damage test.$(element)_resist.pene = @s test.$(element)_resist.pene
