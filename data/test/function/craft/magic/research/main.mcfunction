#> test:craft/magic/research/main
# @s = 研究ステーションのマーカー

execute unless block ~ ~ ~ barrel run function test:craft/magic/research/place

execute unless items block ~ ~ ~ container.26 lime_stained_glass_pane run function test:craft/magic/research/craft
execute unless items block ~ ~ ~ container.26 lime_stained_glass_pane run data modify block ~ ~ ~ Items[{Slot:26}] merge value {id:"lime_stained_glass_pane",components:{custom_data:{test:{button:1b}}}}

clear @a *[custom_data~{test:{button:1b}}]
