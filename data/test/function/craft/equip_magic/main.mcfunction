#> test:craft/equip_magic/main
# @s = 魔法付与台マーカー(test:tickからプレイヤーが近くにいる間だけ毎tick呼ばれる)。強化炉(craft/weapon/upgrade)と同じ作り。
# スロット9に自動発動の枠がある装備、スロット10・11・12に魔法・ルーン・消耗品を置いて、
# スロット26のボタンを取ると1・2・3個目の枠に入れる(test:craft/equip_magic/craft)

execute unless block ~ ~ ~ barrel run function test:craft/equip_magic/place

# 飾り(名前・目印・GUIタイトル)が付いていないステーションに付ける(設置済みのものにも効くよう毎tick確認)
execute unless entity @s[tag=station_decorated] run function test:craft/equip_magic/decorate

execute unless items block ~ ~ ~ container.26 lime_stained_glass_pane run function test:craft/equip_magic/craft
execute unless items block ~ ~ ~ container.26 lime_stained_glass_pane run data modify block ~ ~ ~ Items[{Slot:26}] merge value {id:"lime_stained_glass_pane",components:{custom_data:{test:{button:1b}}}}

clear @a *[custom_data~{test:{button:1b}}]
