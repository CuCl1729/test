#> test:buff/actor/combat
# 内部。@s = 効果を出す側。@macro type: 属性。その属性の与ダメージ補正と耐性貫通を refs へ控える
$execute if score @s test.$(type)_damage.bonus = @s test.$(type)_damage.bonus store result storage test: buff_actor.refs.$(type)_damage_bonus int 1 run scoreboard players get @s test.$(type)_damage.bonus
$execute if score @s test.$(type)_resist.pene = @s test.$(type)_resist.pene store result storage test: buff_actor.refs.$(type)_resist_pene int 1 run scoreboard players get @s test.$(type)_resist.pene
