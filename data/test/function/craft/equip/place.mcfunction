#> test:craft/equip/place
# @s = 設置された防具工房マーカー

setblock ~ ~ ~ barrel
function test:craft/equip/decorate
data modify block ~ ~ ~ Items[{Slot:26}] merge value {id:"lime_stained_glass_pane",components:{custom_data:{test:{button:1b}}}}

tag @s remove summoned
