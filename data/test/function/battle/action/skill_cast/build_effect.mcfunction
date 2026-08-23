#> test:battle/action/skill_cast/build_effect
# @macro id/folder: 効果id と アセット関数の置き場所
# 選択回数ぶんアセット関数を呼ぶ(重ねがけ式の効果はクラフト時に素材の個数ぶん呼ばれるのと同じ形)

scoreboard players set #effect_repeat test.temporary 0
$execute store result score #effect_repeat test.temporary run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.magic.select.effect.$(id)

execute if score #effect_repeat test.temporary matches 1.. run function test:battle/action/skill_cast/build_effect_repeat with storage test: registry_work.effect_entry
