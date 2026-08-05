data remove storage test: status

data modify storage test: status.Tags set from storage test: magic.player.projectile.behavior
data modify storage test: status.speed set from storage test: magic.player.projectile.speed
data modify storage test: status.range set from storage test: magic.player.projectile.range
data modify storage test: status.gravity set from storage test: magic.player.projectile.gravity
data modify storage test: status.data set from storage test: magic.player.data

function test:projectile/shot