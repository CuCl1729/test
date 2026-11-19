#> test:job/skill/magic/prepare
# @s = 詠唱者。@macro job/node: 職業スキル参照。選択中に凍結された古いmacroには頼らず、毎回レジストリから
# 今のノードを読み直し、学習済み/手番で使える種類(test:job/skill/is_battle_active)を確認してから、
# 既存の組み立て(test:job/skill/magic/profile)だけを行う。支払い・ターン消費・届け方はここでは行わない
# (呼び出し元が選んだ届け方へ magic.player をそのまま渡す)

data remove storage test: magic.player
function #oh_my_dat:please

$execute unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.$(job).skills{$(node):1b} run return 0
$execute unless data storage test: asset.job.jobs[{id:"$(job)"}].skills[{id:"$(node)",kind:"magic"}] run return 0

$execute store result score #job_battle_active test.job.work run function test:job/skill/is_battle_active {job:"$(job)",node:"$(node)"}
execute if score #job_battle_active test.job.work matches 0 run return 0

data remove storage test: job_magic_work
$data modify storage test: job_magic_work.job set value "$(job)"
$data modify storage test: job_magic_work.node set value "$(node)"
$data modify storage test: job_magic_work.recipe set from storage test: asset.job.jobs[{id:"$(job)"}].skills[{id:"$(node)"}].params.recipe

return run function test:job/skill/magic/profile with storage test: job_magic_work
