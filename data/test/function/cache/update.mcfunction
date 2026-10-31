function #oh_my_dat:please

# 鉱石を掘って拾った目印を原石に変える(player_data を写す前に行い、equip/recalc が変えた後の持ち物を見るようにする。
# 原石を渡して持ち物がまた変わり、もう一度呼ばれても、目印はもう無いので何もしない)
execute if data entity @s Inventory[].components."minecraft:custom_data".test.ore_token run function test:mine/token/convert
# 釣った目印を素材に変える(同じ理由でここで行う)
execute if data entity @s Inventory[].components."minecraft:custom_data".test.fish_token run function test:fish/token/convert
# 育ちきった作物の目印をバニラの作物に変える(同じ理由でここで行う)
execute if data entity @s Inventory[].components."minecraft:custom_data".test.crop_token run function test:crop/token/convert

data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data set from entity @s

# 防具・アクセサリーの能力を集計し直す(着け外し・持ち替えはどれもインベントリの変化として来る)
function test:equip/recalc

advancement revoke @s only test:cache/change_inventory