#> test:craft/weapon/forge/main
# @s = 鍛冶場マーカー

execute unless block ~ ~ ~ barrel run function test:craft/weapon/forge/place

execute unless items block ~ ~ ~ container.26 lime_stained_glass_pane run function test:craft/weapon/forge/craft
execute unless items block ~ ~ ~ container.26 lime_stained_glass_pane run data modify block ~ ~ ~ Items[{Slot:26}] merge value {id:"lime_stained_glass_pane",components:{custom_data:{test:{button:1b}}}}

clear @a *[custom_data~{test:{button:1b}}]
