#> test:craft/weapon/upgrade/main
# @s = 強化炉マーカー

execute unless block ~ ~ ~ barrel run function test:craft/weapon/upgrade/place

# 飾り(名前・目印・GUIタイトル)が付いていないステーションに付ける(設置済みのものにも効くよう毎tick確認)
execute unless entity @s[tag=station_decorated] run function test:craft/weapon/upgrade/decorate

execute unless items block ~ ~ ~ container.26 lime_stained_glass_pane run function test:craft/weapon/upgrade/craft
execute unless items block ~ ~ ~ container.26 lime_stained_glass_pane run data modify block ~ ~ ~ Items[{Slot:26}] merge value {id:"lime_stained_glass_pane",components:{custom_data:{test:{button:1b}}}}

clear @a *[custom_data~{test:{button:1b}}]
