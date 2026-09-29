#> test:craft/weapon/upgrade/place
# @s = 設置された強化炉マーカー

setblock ~ ~ ~ barrel
function test:craft/weapon/upgrade/decorate
data modify block ~ ~ ~ Items[{Slot:26}] merge value {id:"lime_stained_glass_pane",components:{custom_data:{test:{button:1b}}}}

tag @s remove summoned
