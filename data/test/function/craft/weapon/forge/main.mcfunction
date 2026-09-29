#> test:craft/weapon/forge/main
# @s = 鍛冶場マーカー

execute unless block ~ ~ ~ barrel run function test:craft/weapon/forge/place

# 飾り(名前・目印・GUIタイトル)が付いていないステーションに付ける(設置済みのものにも効くよう毎tick確認)
execute unless entity @s[tag=station_decorated] run function test:craft/weapon/forge/decorate

execute unless items block ~ ~ ~ container.26 lime_stained_glass_pane run function test:craft/weapon/forge/craft
execute unless items block ~ ~ ~ container.26 lime_stained_glass_pane run data modify block ~ ~ ~ Items[{Slot:26}] merge value {id:"lime_stained_glass_pane",components:{custom_data:{test:{button:1b}}}}

clear @a *[custom_data~{test:{button:1b}}]
