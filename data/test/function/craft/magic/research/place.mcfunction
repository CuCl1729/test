#> test:craft/magic/research/place
# @s = 設置された研究ステーションのマーカー

setblock ~ ~ ~ barrel
data modify block ~ ~ ~ Items[{Slot:26}] merge value {id:"lime_stained_glass_pane",components:{custom_data:{test:{button:1b}}}}

tag @s remove summoned
