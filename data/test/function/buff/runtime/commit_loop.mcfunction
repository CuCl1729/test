#> test:buff/runtime/commit_loop
# 内部。@s = 受け手。受け身の取り分の一覧(= ステータスの正本の並び)を先頭から1件ずつ消費して
# キャッシュへ書き戻す。ステータス名をここで別に並べ直すことはしない
execute unless data storage test: buff_runtime.work.stats[0] run return 0
function test:buff/runtime/commit_one with storage test: buff_runtime.work.stats[0]
data remove storage test: buff_runtime.work.stats[0]
function test:buff/runtime/commit_loop
