#> test:job/bundle/rebuild_loop
# job_work.build_queue(skill_orderを反転したもの)を末尾から取り出しつつ、組み立てたアイテムを
# job_work.bundle_itemsの先頭へ差し込む。末尾から取り出して先頭へ差し込むことで、
# 出来上がるbundle_itemsの並びはbuild_queueと同じ順序になる

execute unless data storage test: job_work.build_queue[-1] run return 0

data modify storage test: job_work.build_entry set from storage test: job_work.build_queue[-1]
data remove storage test: job_work.build_queue[-1]

function test:job/bundle/build_entry with storage test: job_work.build_entry

function test:job/bundle/rebuild_loop
