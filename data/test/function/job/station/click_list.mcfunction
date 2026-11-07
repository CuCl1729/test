# @s = Jobステーション。選んだ人について職業の解放を試みる。
data modify storage test: station_action.args set value {}
$data modify storage test: station_action.args.id set from entity @s data.job_ui.page_ids[$(index)]
$function test:station/action/accept {slot:$(slot),call:"job/station/click_list_try_unlock"}
execute unless score #station_claimed test.temporary matches 1 run return run function test:job/station/populate_list
data modify entity @s data.job_ui.job set from storage test: station_action.args.id
data modify entity @s data.job_ui.view set value "tree"
data modify entity @s data.job_ui.page set value 0
function test:job/station/populate_tree
