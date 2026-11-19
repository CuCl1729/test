#> test:buff/resource/apply
# 内部。的(@s)の上で動く。いま配られている仕事の資源行(heal / damage)を、
# 選ばれた単位ぶんまとめて一度だけ当てる。回復と防御無視(type:"true")は凍結された生の値をそのまま使う。
# 属性付きのダメージだけ、段ごとに軽減してから当てる(test:buff/resource/mitigate。会心・神秘・乱数は無い)。
# 容量は飽和する引き算で削るので、合計が int32 を超えても桁あふれしない

data remove storage test: buff_resource
data modify storage test: buff_resource.arg set value {}
data modify storage test: buff_resource.arg.resource set from storage test: buff_event.row.resource
data modify storage test: buff_resource.arg.i set from storage test: buff_event.row.row
# 撃破者もこの軽減後の値で選ぶ(credit は buff_event.units を読む)
execute if data storage test: buff_event.row{kind:"damage"} unless data storage test: buff_event.row{type:"true"} run function test:buff/resource/mitigate with storage test: buff_event.row
data modify storage test: buff_resource.rest set from storage test: buff_event.units

function test:buff/resource/read with storage test: buff_resource.arg

# 足し込める量。回復は残りの容量、消耗は今の残量。上限はこの回では設定で変えられない
scoreboard players set #br_budget test.buff.work 0
execute if data storage test: buff_event.row{kind:"heal"} run scoreboard players operation #br_budget test.buff.work = #br_max test.buff.work
execute if data storage test: buff_event.row{kind:"heal"} run scoreboard players operation #br_budget test.buff.work -= #br_cur test.buff.work
execute if data storage test: buff_event.row{kind:"damage"} run scoreboard players operation #br_budget test.buff.work = #br_cur test.buff.work
execute if score #br_budget test.buff.work matches ..-1 run scoreboard players set #br_budget test.buff.work 0

scoreboard players set #br_applied test.buff.work 0
execute if data storage test: buff_resource.rest[0] run function test:buff/resource/unit with storage test: buff_resource.arg
execute if score #br_applied test.buff.work matches 0 run return 0

scoreboard players operation #br_new test.buff.work = #br_cur test.buff.work
execute if data storage test: buff_event.row{kind:"heal"} run scoreboard players operation #br_new test.buff.work += #br_applied test.buff.work
execute if data storage test: buff_event.row{kind:"damage"} run scoreboard players operation #br_new test.buff.work -= #br_applied test.buff.work
function test:buff/resource/write with storage test: buff_resource.arg

# HPが「正から0へ」落ちたときだけ、功績を残して既存の死亡処理へ渡す。
# もう0だった的には届かないので、前の功績を上書きしない。MPの消耗では死なない
execute unless data storage test: buff_event.row{kind:"damage",resource:"hp"} run return 0
execute unless score #br_cur test.buff.work matches 1.. run return 0
execute unless score #br_new test.buff.work matches 0 run return 0
function test:buff/resource/credit
function test:damage/kill
