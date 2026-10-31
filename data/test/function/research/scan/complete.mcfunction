#> test:research/scan/complete
# @s = プレイヤー。@macro id/name/gain: 初めて調べ終えた観測(asset.scan.<id>)。知識を足し、調べ済みにする

$data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.research.scanned.$(id) set value 1b
$data modify storage test: research_work.kq set from storage test: asset.scan.$(id).knowledge
function test:research/knowledge_add_loop
$tellraw @s [{text:"調べた: ",color:"gold"},{text:"$(name)",color:"white"},{text:" $(gain)",color:"aqua"}]
$title @s actionbar [{text:"調べた: ",color:"gold"},{text:"$(name)",color:"white"}]
