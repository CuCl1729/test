#> test:research/sync_known
# @s = プレイヤー。解放するもののどれかがもう記録されている研究(研究を入れる前に習得した魔法要素など)を、済にする。
# 研究のGUIを描くたびに呼ぶ(test:craft/magic/research/populate_top)。終わっても oh_my_dat は @s を指したまま

function #oh_my_dat:please
data modify storage test: research_work.sync_ids set from storage test: asset.research_ids
function test:research/sync_loop
