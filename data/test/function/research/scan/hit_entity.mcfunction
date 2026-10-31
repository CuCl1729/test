#> test:research/scan/hit_entity
# @s = プレイヤー。視線が tag=scan_hit のエンティティに当たった。一番近いものを asset.scan_entity と照合する

scoreboard players set #scan_hit test.temporary 1
data modify storage test: research_work.q set from storage test: asset.scan_entity
execute as @n[tag=scan_hit] run function test:research/scan/match_entity
tag @e[tag=scan_hit] remove scan_hit
