#> test:init/asset/job/
# 職業(job)レジストリを組み立て直す(test:init/asset/から呼ばれる)。
# asset.job.jobs = [{id, label, color, requires:[{job,level}], exp_coefficient, growth:[{stat,per_level}],
#   skills:[{id, label, requires_level, requires_nodes, cost, kind, params}]}]
# 並び順がJobステーションの表示順。前提条件はプレイヤー側のoh_my_datを見て判定する

data remove storage test: asset.job.jobs
data modify storage test: asset.job.jobs set value []

# 各職業とスキルの宣言はスプレッドシートから生成している(tools/datasheet/generate.ps1。生成先はgenerated/)
function test:init/asset/job/generated/jobs
