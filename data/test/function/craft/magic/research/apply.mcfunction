#> test:craft/magic/research/apply
# @s = 研究を行うプレイヤー（位置は研究ステーション）。スキルポイントを1消費して素材に対応する要素を習得する

execute unless score @s test.status.skill_point matches 1.. run return 0

function test:craft/magic/research/type with block ~ ~ ~ Items[{Slot:9b}].components."minecraft:custom_data".test.magic
function test:craft/magic/research/effect with block ~ ~ ~ Items[{Slot:9b}].components."minecraft:custom_data".test.magic
function test:craft/magic/research/status with block ~ ~ ~ Items[{Slot:9b}].components."minecraft:custom_data".test.magic
