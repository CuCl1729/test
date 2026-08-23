#> test:battle/ui/skill_type_minecart_populate
# @s = タイプ選択中のプレイヤー(トロッコ式)。現在の選択状態を全スロットへ反映し直す
# (クラフター方式: アイコンは取っても消費されず、選択のON/OFFが名前に反映されてカートへ戻る)
# レジストリ(test:init/asset/magic/types)を走査するので、タイプを増やしてもここは無改修

data remove entity @n[tag=skill_minecart,tag=!target_minecart,tag=!skill_effect_minecart] Items

function #oh_my_dat:please

# 取られたスロット番号からタイプを引けるよう、スロット順のidを控えておく
data remove storage test: battle.temporary.type_slot

scoreboard players set #type_slot test.temporary 0
function test:magic/registry/queue_types
function test:battle/ui/skill_type_minecart_populate_loop

data modify entity @n[tag=skill_minecart,tag=!target_minecart,tag=!skill_effect_minecart] Items append value {Slot:8b,id:"ender_eye",count:1,components:{"minecraft:custom_name":{text:"決定する",italic:false},"minecraft:custom_data":{test:{skill_choice:"confirm"}}}}
