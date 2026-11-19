#> test:buff/events/frame_dat
# 内部。OhMyDat の居場所を、退避した ID へ正確に戻す。
# 入れ子の相手に #please を撃つだけでは元の相手へは戻らないので、本家の提供をもう一度通す
# (木の付け替えは oh_my_dat:sys/provide に任せる。ライブラリ側には手を入れない)

execute store result score #bq_dat test.buff.work run data get storage test: buff_frames.stack[0].dat
execute if score #bq_dat test.buff.work matches ..0 run return 0

data modify storage oh_my_dat: target_id set from storage test: buff_frames.stack[0].dat
data modify storage oh_my_dat: last_id set from storage test: buff_frames.stack[0].dat
scoreboard players operation _ OhMyDatID = #bq_dat test.buff.work
function oh_my_dat:sys/provide
return 1
