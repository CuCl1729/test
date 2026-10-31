#> test:research/sync_known
# @s = プレイヤー。研究を入れる前の進み具合を移す、1人1回だけの処理(印 test.research.migrated が無いときだけ動き、終わったら付ける)。
# 解放するものが全部もう記録されている研究(前に習得した魔法要素など)を済にする。
# 研究のGUIを描くたびに呼ばれる(test:craft/magic/research/populate_top)。終わっても oh_my_dat は @s を指したまま

function #oh_my_dat:please
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.research.migrated run return 0
data modify storage test: research_work.sync_ids set from storage test: asset.research_ids
function test:research/sync_loop
data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.research.migrated set value 1b
