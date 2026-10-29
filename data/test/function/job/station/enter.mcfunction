#> test:job/station/enter
# @s = Jobステーションのマーカー(実行位置は樽)。設置したときに画面を作る(test:station/enter_mode が呼ぶ)
# page は「先頭から読み飛ばす件数」(魔法台の研究と同じ。test:job/station/click_arrow)

data modify entity @s data.job_ui set value {view:"list",job:"",page:0,has_next:0b,page_ids:[],node_ids:[]}
function test:job/station/populate_list
