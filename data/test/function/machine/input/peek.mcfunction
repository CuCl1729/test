#> test:machine/input/peek
# @s = 機械のマーカー。@macro l/u/f: 原石の入れ物の位置。何か入っていれば #machine_has_input を1にする

$execute positioned ^$(l) ^$(u) ^$(f) if data block ~ ~ ~ Items[0] run scoreboard players set #machine_has_input test.temporary 1
