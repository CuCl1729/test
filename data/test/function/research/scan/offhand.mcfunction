#> test:research/scan/offhand
# @s = プレイヤー。視線の先に何も無いとき、左手のアイテムを asset.scan_item と照合する(空なら何もしない)

execute unless items entity @s weapon.offhand * run return 0
data modify storage test: research_work.q set from storage test: asset.scan_item
function test:research/scan/match_item
