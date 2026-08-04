#> test:craft/weapon/upgrade/main
# @s = 強化炉マーカー

execute unless block ~ ~ ~ barrel run function test:craft/weapon/upgrade/place

execute unless items block ~ ~ ~ container.26 lime_stained_glass_pane run function test:craft/weapon/upgrade/craft
execute unless items block ~ ~ ~ container.26 lime_stained_glass_pane run data modify block ~ ~ ~ Items[{Slot:26}] merge value {id:"lime_stained_glass_pane",components:{custom_data:{test:{button:1b}}}}

clear @a *[custom_data~{test:{button:1b}}]
