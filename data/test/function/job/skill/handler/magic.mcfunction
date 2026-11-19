#> test:job/skill/handler/magic
# @s = 発動するプレイヤー(職業スキル)。@macro recipe: このノードが参照する魔法レシピid。
# job/nodeは呼び出し元(test:job/skill/use)が読み込んだjob_work.skill_entryから取る
# (将来の生成器もrecipe=<id>のまま渡せるよう、ここのmacroはrecipeだけにする)。
# 学習済み/アクティブ/ダウン判定は既存のtest:job/skill/useで済んでいるので、ここでは支払いも武器化もしない

data modify storage test: job_magic_work set value {recipe:"",job:"",node:""}
$data modify storage test: job_magic_work.recipe set value "$(recipe)"
data modify storage test: job_magic_work.job set from storage test: job_work.skill_entry.job
data modify storage test: job_magic_work.node set from storage test: job_work.skill_entry.id

function test:job/skill/magic/use with storage test: job_magic_work
