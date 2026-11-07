# @s = Jobステーション。取得者本人のポイントと習得条件を確かめる。
data modify storage test: station_action.args set value {}
data modify storage test: station_action.args.job set from entity @s data.job_ui.job
$data modify storage test: station_action.args.node set from entity @s data.job_ui.node_ids[$(index)]
$function test:station/action/accept {slot:$(slot),call:"job/skill/unlock"}
function test:job/station/populate_tree
