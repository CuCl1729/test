#> test:craft/equip_magic/take_one
# @s = 付与台マーカー。@macro slot: スロット番号。そのスロットのアイテムを1個だけ減らす(1個なら消す)。
# ルーンやアクセサリーは重なるので、スロットを丸ごと消すと重ねた分まで失われるため

$execute store result score #take_count test.temporary run data get block ~ ~ ~ Items[{Slot:$(slot)b}].count
scoreboard players remove #take_count test.temporary 1
$execute if score #take_count test.temporary matches ..0 run return run data remove block ~ ~ ~ Items[{Slot:$(slot)b}]
$execute store result block ~ ~ ~ Items[{Slot:$(slot)b}].count int 1 run scoreboard players get #take_count test.temporary
