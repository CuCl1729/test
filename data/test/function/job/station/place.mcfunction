#> test:job/station/place
# @s = 設置されたJobステーション本体(バレルの位置)。初回描画を行う

setblock ~ ~ ~ barrel

data modify entity @s data.job_ui set value {view:"list",job:"",page_ids:[],node_ids:[]}
function test:job/station/populate_list

tag @s remove summoned
