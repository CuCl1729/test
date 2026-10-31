#> test:farm/look_set
# @s = 魔法作物(interaction)。@macro block/age: 見た目のブロックと age

$execute at @s align xyz as @e[type=block_display,tag=magic_crop_display,distance=..0.1] run data modify entity @s block_state set value {id:"$(block)",properties:{age:"$(age)"}}
