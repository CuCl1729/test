#> test:research/scan/match_block_one
# @macro id/block: 観測のidとブロックのid

$execute if block ~ ~ ~ $(block) run data modify storage test: research_work.found set value "$(id)"
