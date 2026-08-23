#> test:battle/ui/skill_effect_toggle
# @s = 効果をトグルしたプレイヤー。@macro id: 切り替える効果id  @macro max: 循環させる段階数
# 加算してmaxで割った余りを取ることで循環させる(max=2ならON/OFF、max=4なら0〜3の重ねがけ)

function #oh_my_dat:please

scoreboard players set #select test.temporary 0
$execute store result score #select test.temporary run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.magic.select.effect.$(id)

scoreboard players add #select test.temporary 1
$scoreboard players set #toggle_max test.temporary $(max)
scoreboard players operation #select test.temporary %= #toggle_max test.temporary

$execute store result storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.magic.select.effect.$(id) int 1 run scoreboard players get #select test.temporary
