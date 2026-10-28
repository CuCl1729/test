data modify storage test: magic.loot.status.projectile.behavior append value "gravity"

$data modify storage test: magic.loot.status.projectile.gravity set value $(gravity)

$scoreboard players add #cost test.temporary $(cost)