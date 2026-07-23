execute unless block ~ ~ ~ barrel run kill @n[type=item,nbt={Item:{id:"minecraft:barrel"}}]
execute unless block ~ ~ ~ barrel run kill @n[type=item,nbt={Item:{id:"minecraft:lime_stained_glass_pane"}}]
execute unless block ~ ~ ~ barrel run function test:asset/machine/magic/crafter
execute unless block ~ ~ ~ barrel run return run tag @s add kill

execute unless items block ~ ~ ~ container.26 lime_stained_glass_pane run function test:magic/crafter/pre_craft

execute unless items block ~ ~ ~ container.26 lime_stained_glass_pane run data remove block 0 -64 0 Items[{Slot:0b}].id
execute unless items block ~ ~ ~ container.26 lime_stained_glass_pane run data remove block 0 -64 0 Items[{Slot:0b}].components
execute unless items block ~ ~ ~ container.26 lime_stained_glass_pane run data remove block 0 -64 0 Items[{Slot:0b}].count

execute unless items block ~ ~ ~ container.26 lime_stained_glass_pane run data modify block 0 -64 0 Items[{Slot:0b}].id set from block ~ ~ ~ Items[{Slot:26b}].id
execute unless items block ~ ~ ~ container.26 lime_stained_glass_pane run data modify block 0 -64 0 Items[{Slot:0b}].components set from block ~ ~ ~ Items[{Slot:26b}].components
execute unless items block ~ ~ ~ container.26 lime_stained_glass_pane run data modify block 0 -64 0 Items[{Slot:0b}].count set from block ~ ~ ~ Items[{Slot:26b}].count

execute unless items block ~ ~ ~ container.26 lime_stained_glass_pane run loot spawn ~ ~1 ~ mine 0 -64 0 debug_stick
data modify block ~ ~ ~ Items[{Slot:26}] merge value {id:"lime_stained_glass_pane",components:{custom_data:{test:{button:1b}}}}

clear @a *[custom_data~{test:{button:1b}}]