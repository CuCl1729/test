function #oh_my_dat:please

data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data set from entity @s

# 防具・アクセサリーの能力を集計し直す(着け外し・持ち替えはどれもインベントリの変化として来る)
function test:equip/recalc

advancement revoke @s only test:cache/change_inventory