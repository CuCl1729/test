data modify storage test: magic.loot.status.effect append value "heal"

$data modify storage test: magic.loot.status.heal set value {power:$(power)}

$scoreboard players add #cost test.temporary $(cost)