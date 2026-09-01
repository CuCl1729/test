#> test:buff/apply_list
# @s = 付与対象。storage test: buff_work.pending に用意されたぶんをまとめて付与する
# (魔法・敵の攻撃・武器といった付与元の共通入口)
#
# 1件の形: {id:"poison",stacks:1} / 確率を付けたい場合は {id:"poison",stacks:1,chance:50}
# pendingは消費せずコピーして使う。複数の対象へ「as @e[...] run function test:buff/apply_list」と
# 同じ一覧を配れるようにするため

data modify storage test: buff_work.queue set from storage test: buff_work.pending
function test:buff/apply_queue_loop
