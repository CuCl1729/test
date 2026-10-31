#> test:research/scan/match_entity
# @s = 視線が当たったエンティティ。research_work.q(asset.scan_entity のコピー)を先頭から見て、最初に合う観測を research_work.found に入れる

execute unless data storage test: research_work.q[0] run return 0
function test:research/scan/match_entity_one with storage test: research_work.q[0]
execute unless data storage test: research_work{found:""} run return 1
data remove storage test: research_work.q[0]
function test:research/scan/match_entity
