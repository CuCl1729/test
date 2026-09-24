#> test:job/skill/load_entry
# @macro job/node: 職業id・ノードid。レジストリから該当スキル1件をjob_work.skill_entryへ読み込み、
# 呼び出し元が使い回せるよう.jobフィールド(職業id)も足しておく

$data modify storage test: job_work.skill_entry set from storage test: asset.job.jobs[{id:"$(job)"}].skills[{id:"$(node)"}]
$data modify storage test: job_work.skill_entry.job set value "$(job)"
