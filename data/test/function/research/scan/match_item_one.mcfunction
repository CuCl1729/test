#> test:research/scan/match_item_one
# @s = プレイヤー。@macro id/pred: 観測のidと、if items の条件(例: minecraft:wheat / *[minecraft:custom_data~{…}])

$execute if items entity @s weapon.offhand $(pred) run data modify storage test: research_work.found set value "$(id)"
