#> test:damage/apply_type
#
# 指定した属性(type)について、抵抗力・ダメージ増加率・防御係数を適用し、
# 対象のHPを減算する。damage/ から属性ごとに呼び出される。
# @macro type: fire | water | wood | metal | earth | physics

$scoreboard players operation #victim test.$(type)_resist = @s test.$(type)_resist
$scoreboard players operation #victim test.$(type)_damage_inc.bonus = @s test.$(type)_damage_inc.bonus

$scoreboard players operation #victim test.$(type)_resist -= #100 test.constant
$scoreboard players operation #victim test.$(type)_resist *= #-1 test.constant
$scoreboard players operation #victim test.$(type)_resist += #damage test.$(type)_resist.pene
$scoreboard players operation #victim test.$(type)_resist += @s test.$(type)_resist.debuff
$scoreboard players operation #victim test.$(type)_damage *= #victim test.$(type)_resist
$scoreboard players operation #victim test.$(type)_damage /= #100 test.constant

$scoreboard players operation #victim test.$(type)_damage *= #victim test.$(type)_damage_inc.bonus
$scoreboard players operation #victim test.$(type)_damage /= #100 test.constant

$scoreboard players operation #victim test.$(type)_damage *= #victim test.status.def
$scoreboard players operation #victim test.$(type)_damage /= #100 test.constant

$execute if score #victim test.$(type)_damage matches ..-1 run scoreboard players set #victim test.$(type)_damage 2147483647

$scoreboard players operation @s test.status.hp -= #victim test.$(type)_damage