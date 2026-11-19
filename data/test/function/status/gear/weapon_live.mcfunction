#> test:status/gear/weapon_live
# @s = プレイヤー。今メインハンドに持っているものの custom_data を装備計算の入口へ写す
# (test:status/gear/one が読む。本物の武器を持っているときだけ呼ぶ)

function #oh_my_dat:please
data modify storage test: status_gear.weapon set value {}
data modify storage test: status_gear.weapon set from storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components."minecraft:custom_data"
