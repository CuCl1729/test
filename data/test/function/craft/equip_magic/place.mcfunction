#> test:craft/equip_magic/place
# @s = 設置された魔法付与台マーカー

setblock ~ ~ ~ barrel
function test:craft/equip_magic/decorate
data modify block ~ ~ ~ Items[{Slot:26}] merge value {id:"lime_stained_glass_pane",components:{custom_data:{test:{button:1b}}}}

tag @s remove summoned
