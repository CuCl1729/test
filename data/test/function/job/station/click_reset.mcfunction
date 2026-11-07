#> test:job/station/click_reset
# @s = Jobステーション。[スキルをリセット]を取った本人に、表示中の職業のリセット確認を出す

data modify storage test: station_action.args set value {}
data modify storage test: station_action.args.job set from entity @s data.job_ui.job
data modify storage test: station_action.args.station set from entity @s UUID
function test:station/action/accept {slot:26,call:"job/reset/request"}
function test:job/station/populate_tree
