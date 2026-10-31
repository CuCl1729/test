#> test:research/scan/match_entity_one
# @s = エンティティ。@macro id/sel: 観測のidと、セレクタの中身(例: tag=goblin / type=minecraft:cow)

$execute if entity @s[$(sel)] run data modify storage test: research_work.found set value "$(id)"
