#> test:research/scan/hit_block
# @s = プレイヤー。実行位置 = 視線が当たったブロック。asset.scan_block と照合する

scoreboard players set #scan_hit test.temporary 1
data modify storage test: research_work.q set from storage test: asset.scan_block
function test:research/scan/match_block
