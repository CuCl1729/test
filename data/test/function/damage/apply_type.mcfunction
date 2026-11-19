#> test:damage/apply_type
#
# 指定した属性(type)について、抵抗力・ダメージ増加率・防御係数を適用し、
# 対象のHPを減算する。damage/ から属性ごとに呼び出される。
# @macro type: fire | water | wood | metal | earth | physics

$function test:damage/type_scale {type:"$(type)"}

# HPを引く。ダメージが今のHP以上なら0にする(HPが既に負のときに大きな値を引くと、値が回って正に戻り生き返るため)
$execute if score #victim test.$(type)_damage >= @s test.status.hp run return run scoreboard players set @s test.status.hp 0
$scoreboard players operation @s test.status.hp -= #victim test.$(type)_damage
