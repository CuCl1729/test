#> test:magic/build_name
# @s = クラフター本体。data entity @s data.crafter_ui.build (要素を追加した順序のidリスト。
# 同じidが複数あってもよい)を先頭から歩き、レジストリのnameフラグメントをstorage test: magic.loot.name
# へ積む(同じidは最初の1回だけ)。効果の組み立て(cost・type_flags等)とは別に、ここでまとめて行う
#
# 呼び出し前提: 直前に test:asset/magic/reset が呼ばれ、magic.loot.nameが初期値[""]になっていること
# (test:magic/crafter/rebuild が reset→効果の再構築→この関数、の順に呼ぶ)
#
# [-1]から取り出す方が軽いが、それだと追加順と逆になってしまうため、レジストリ走査と同じ要領
# (test:magic/registry/reverse_loop)で一度反転してから、改めて末尾から取り出して処理する

data modify storage test: registry_work.reverse_src set value []
execute if data entity @s data.crafter_ui.build[0] run data modify storage test: registry_work.reverse_src set from entity @s data.crafter_ui.build
data remove storage test: registry_work.reverse_dst
function test:magic/registry/reverse_loop

data modify storage test: registry_work.name_seen set value []

function test:magic/build_name_loop
