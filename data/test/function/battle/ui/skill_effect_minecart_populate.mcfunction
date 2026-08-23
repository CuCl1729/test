#> test:battle/ui/skill_effect_minecart_populate
# @s = 効果選択中のプレイヤー(トロッコ式)。現在の選択状態を全スロットへ反映し直す
# (クラフター方式: アイコンは取っても消費されず、選択のON/OFFが名前に反映されてカートへ戻る)
# レジストリ(test:init/asset/magic/effects)を走査するので、効果を増やしてもここは無改修

data remove entity @n[tag=skill_effect_minecart] Items

function #oh_my_dat:please
function test:battle/ui/skill_effect_categories

# 取られたスロット番号から効果を引けるよう、スロット順のidを控えておく
data remove storage test: battle.temporary.effect_slot

scoreboard players set #effect_slot test.temporary 0
function test:magic/registry/queue_effects
function test:battle/ui/skill_effect_minecart_populate_loop

data modify entity @n[tag=skill_effect_minecart] Items append value {Slot:8b,id:"ender_eye",count:1,components:{"minecraft:custom_name":{text:"詠唱する",italic:false},"minecraft:custom_data":{test:{skill_effect:"cast"}}}}
