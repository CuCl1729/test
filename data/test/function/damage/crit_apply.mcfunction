#> test:damage/crit_apply
# @macro type: fire | water | wood | metal | earth | physics

$scoreboard players operation #victim test.$(type)_damage *= #damage test.status.crit_damage
$scoreboard players operation #victim test.$(type)_damage /= #100 test.constant