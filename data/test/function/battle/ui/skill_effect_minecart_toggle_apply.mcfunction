#> test:battle/ui/skill_effect_minecart_toggle_apply
# @s = 効果アイコンを取ったプレイヤー。@macro slot_pick: 取られたスロットが表す効果id
# 加算してmaxで割った余りを取ることで循環させる(max=2ならON/OFF、max=4なら0〜3の重ねがけ)

function #oh_my_dat:please

scoreboard players set #select test.temporary 0
$execute store result score #select test.temporary run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.magic.select.effect.$(slot_pick)

scoreboard players add #select test.temporary 1
$execute store result score #toggle_max test.temporary run data get storage test: asset.magic.effects[{id:"$(slot_pick)"}].max
scoreboard players operation #select test.temporary %= #toggle_max test.temporary

$execute store result storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.magic.select.effect.$(slot_pick) int 1 run scoreboard players get #select test.temporary

# 拾ったアイコン自体は手元から消す(消費しないクラフター方式)
$clear @s *[custom_data~{test:{skill_effect:"$(slot_pick)"}}]
