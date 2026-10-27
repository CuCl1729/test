#> test:equip/accessory_part
# @macro n: 何個目のアクセサリーか(1から)。自動発動の枠のキーの部位の部分を "acc<n>" にする

$data modify storage test: equip_work.part set value "acc$(n)"
