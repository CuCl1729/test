#> test:gather/match
# @s = 採取ポイント(interaction)。押した人(interaction.player)が gather_work.uuid と同じなら tag=gather_target を付け、データを消す

data modify storage test: gather_work.cmp set from storage test: gather_work.uuid
execute store success score #gather_diff test.temporary run data modify storage test: gather_work.cmp set from entity @s interaction.player
execute if score #gather_diff test.temporary matches 1 run return 0
tag @s add gather_target
data remove entity @s interaction
