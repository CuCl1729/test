#> test:magic/crafter/build_effect_loop
# registry_work.build_queue(data.crafter_ui.buildのコピー)を末尾から取り出して1件ずつ組み立てる。
# 効果の重ねがけ(#atk_stack等)は順序非依存に集計する設計なので、末尾からの処理で問題ない
# (test:magic/build_nameのように追加順を保つ必要がないため、reverse_loopを挟まず直接処理できる)

execute unless data storage test: registry_work.build_queue[-1] run return 0

data modify storage test: registry_work.build_id set from storage test: registry_work.build_queue[-1]
data remove storage test: registry_work.build_queue[-1]

function test:magic/crafter/build_effect_entry with storage test: registry_work

function test:magic/crafter/build_effect_loop
