#> test:job/station/enter
# @s = Jobステーションのマーカー(実行位置は樽)。設置したときに画面を作る(test:station/enter_mode が呼ぶ)

data modify entity @s data.job_ui set value {view:"list",job:"",page_ids:[],node_ids:[]}
function test:job/station/populate_list
