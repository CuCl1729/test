#> test:machine/shape/casing_find
# 実行位置 = 筐体のブロック。asset.casing_ids を順に試し、そのブロックの筐体の種類を machine_work.casing / casing_def にする

data modify storage test: machine_work.casing_queue set from storage test: asset.casing_ids
function test:machine/shape/casing_find_loop
