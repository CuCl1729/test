#> test:research/grant
# @s = プレイヤー(oh_my_dat は @s を指している)。@macro id: 研究のid。コストは払わず、済にして解放のものを全部記録する
# (記録先は解放の path: 魔法要素は今までの test.magic.known、ほかは test.unlock.<種類>)

$data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.research.done.$(id) set value 1b
$data modify storage test: research_work.uq set from storage test: asset.research.$(id).unlock
function test:research/grant_loop
