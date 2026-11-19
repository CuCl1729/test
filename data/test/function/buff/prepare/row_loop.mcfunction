#> test:buff/prepare/row_loop
# 内部。work.rows を先頭から1件ずつ消費して work.out へ控える。
# function 行は評価せずそのまま写し、stat/heal/damage は value を足す

execute unless data storage test: buff_prepare.work.rows[0] run return 0

data modify storage test: buff_prepare.work.row set from storage test: buff_prepare.work.rows[0]
data remove storage test: buff_prepare.work.rows[0]

# 設定を直したあとでも別々に宣言した行を見分けられるように、元の記述(path/tag/event/stat/mode/
# resource/type/terms/flat/reference_flat)はそのまま残し、行番号と値だけを足す。
# 行番号は定義内の位置を指すだけで、これだけを根拠に別の世代の行をまとめてよいという意味ではない
execute store result storage test: buff_prepare.work.row.row int 1 run scoreboard players get #bp_i test.buff.work

execute if data storage test: buff_prepare.work.row{kind:"stat"} run function test:buff/prepare/value
execute if data storage test: buff_prepare.work.row{kind:"heal"} run function test:buff/prepare/value
execute if data storage test: buff_prepare.work.row{kind:"damage"} run function test:buff/prepare/value

# 1行でも評価に失敗したら、受理した行を部分的に残さずここで打ち切る
execute if data storage test: buff_prepare.result run return 0

data modify storage test: buff_prepare.work.out append from storage test: buff_prepare.work.row
scoreboard players add #bp_i test.buff.work 1

function test:buff/prepare/row_loop
