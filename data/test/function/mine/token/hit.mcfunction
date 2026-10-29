#> test:mine/token/hit
# @macro rare: 当たったレア度(ほかのキーも渡ってくるが使わない)。そのレア度の個数を1増やす

$scoreboard players add #ore_r$(rare) test.temporary 1
scoreboard players set #ore_hit test.temporary 1
