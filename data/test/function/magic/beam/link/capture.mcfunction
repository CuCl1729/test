#> test:magic/beam/link/capture
# @s = 持続ビームの実体。実行位置・向き = 今回の光線の到達点とその向き。#beam_index test.temporary = 光線の番号。
# link_work.wall = 壁に当たった座標(当たっていなければ無い)。#beam_link_delta test.temporary = 今回分の経過tick。
# 可視猶予中(delta<=0)や、着弾/一定間隔につながっていないビームは何もしない
execute if score #beam_link_delta test.temporary matches ..0 run return 0
execute unless data storage test: link_work.template.kind run return 0

data remove storage test: beam_link_capture_work
execute store result storage test: beam_link_capture_work.index int 1 run scoreboard players get #beam_index test.temporary
function test:magic/beam/link/capture_entry with storage test: beam_link_capture_work
