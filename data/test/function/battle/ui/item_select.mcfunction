#> test:battle/ui/item_select
# @s = 行動を選んだプレイヤー。$(action) = 選んだ行動

clear @s minecraft:iron_sword[custom_data~{test:{battle_action:"attack"}}]
clear @s minecraft:potion[custom_data~{test:{battle_action:"item"}}]
clear @s minecraft:shield[custom_data~{test:{battle_action:"defend"}}]
# 攻撃/アイテム/防御を選んだ場合、スキル選択を保留中だったならここでキャンセル扱いにする
# (blaze_powderが残ったままだと次ターンに持ち越されてしまうため)
clear @s minecraft:blaze_powder[custom_data~{test:{battle_action:"skill"}}]
kill @e[tag=skill_minecart,distance=..8]

$function test:battle/action/$(action)