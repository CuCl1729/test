#> test:battle/ui/target_minecart_populate
# @s = 対象選択中のプレイヤー(トロッコ式)。生存している対象候補を全スロットへ反映し直す
# (最大8体まで。各スロットが表す対象のturn_orderをストレージへ控えておき、
#  取られた時にどの対象かを引けるようにする)

data remove entity @n[tag=target_minecart] Items
data remove storage test: battle.temporary.target_slot

scoreboard players set #target_slot test.temporary 0
execute as @e[tag=battle_member,tag=enemy,distance=..64,scores={test.status.hp=1..}] run function test:battle/ui/target_minecart_populate_slot

data modify entity @n[tag=target_minecart] Items append value {Slot:8b,id:"ender_eye",count:1,components:{"minecraft:custom_name":{text:"決定する",italic:false},"minecraft:custom_data":{test:{target_pick:"confirm"}}}}
