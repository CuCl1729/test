#> test:battle/action/active_skill_queue_entry
# @s = 詠唱者(チャット式)。@macro job/node/index: 職業スキル参照1件+一覧上の番号
# (registry_work.active_skill_entryとして展開済み)

data modify storage test: battle.temporary.active_skill_slot append value {kind:"job",job:"",node:""}
$data modify storage test: battle.temporary.active_skill_slot[-1].job set value "$(job)"
$data modify storage test: battle.temporary.active_skill_slot[-1].node set value "$(node)"

$function test:job/skill/load_entry {job:"$(job)",node:"$(node)"}
$data modify storage test: job_work.skill_entry.index set value $(index)

function test:battle/action/active_skill_queue_line with storage test: job_work.skill_entry
