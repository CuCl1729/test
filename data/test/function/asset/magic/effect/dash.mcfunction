data modify storage test: magic.loot.status.effect append value "dash"

$data modify storage test: magic.loot.status.dash set value {distance:$(distance)}

$scoreboard players add #cost test.temporary $(cost)
