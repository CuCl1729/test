$data modify storage test: magic.loot.status.place set value {life:$(life)}

# 設置は届け方。置いた物(test:magic/place/)はそれ自体は効果を持たず、後ろのつなぎで次の段を始める
data modify storage test: magic.loot.status.magic_type set value "place"
data modify storage test: magic.loot.status.type_flags.place set value 1b
data modify storage test: magic.loot.status.types append value "place"

scoreboard players add #delivery_count test.temporary 1
$scoreboard players add #cost test.temporary $(cost)
