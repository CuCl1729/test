#> test:magic/beam/link/capture_entry
# @macro index: 今回の光線の番号。@s・実行位置は capture と同じ(光線の到達点とその向き)。
# link_work.states から index のぶんを探し(無ければ新規)、着弾/一定間隔の状態を1回だけ進め、
# 要るときだけその場で emit を呼ぶ。最後に古い分を外して更新した分だけ積み直す(他の光線の分はそのまま残す)
$data modify storage test: link_state_work set value {index:$(index)}
scoreboard players set #beam_link_found test.temporary 0
$execute store success score #beam_link_found test.temporary run data modify storage test: link_state_work set from storage test: link_work.states[{index:$(index)}]
$data remove storage test: link_work.states[{index:$(index)}]

# 着弾で: 壁の有無と、同じ複合値かどうかだけを見る。`set from` は実際に値が変わったときだけ1を返すので、
# 「同じブロックに留まっている」と「無かった壁に初めて/また当たった」をこの1回の操作で区別できる
# (壁から外れたときは出来事を積まず、掴んでいた記録だけ外す)
execute if data storage test: link_work.template{kind:"on_land"} unless data storage test: link_work.wall if data storage test: link_state_work.last_wall run data remove storage test: link_state_work.last_wall

execute if data storage test: link_work.template{kind:"on_land"} if data storage test: link_work.wall store success score #beam_link_wall_changed test.temporary run data modify storage test: link_state_work.last_wall set from storage test: link_work.wall
execute if data storage test: link_work.template{kind:"on_land"} if data storage test: link_work.wall if score #beam_link_wall_changed test.temporary matches 1 run function test:magic/beam/link/emit

# 一定間隔で: 持ち主の短縮を初めに1回だけ反映した間隔で数える。残りが尽きたら以後は何もしない(catch-upもしない)
execute if data storage test: link_work.template{kind:"periodic"} if score #beam_link_found test.temporary matches 0 run data modify storage test: link_state_work.timer set from storage test: link_work.template.interval_ticks
execute if data storage test: link_work.template{kind:"periodic"} if score #beam_link_found test.temporary matches 0 run data modify storage test: link_state_work.count set from storage test: link_work.template.count

scoreboard players set #beam_link_count test.temporary 0
execute if data storage test: link_work.template{kind:"periodic"} store result score #beam_link_count test.temporary run data get storage test: link_state_work.count
scoreboard players set #beam_link_active test.temporary 0
execute if score #beam_link_count test.temporary matches 1.. run scoreboard players set #beam_link_active test.temporary 1

execute if score #beam_link_active test.temporary matches 1 store result score #beam_link_timer test.temporary run data get storage test: link_state_work.timer
execute if score #beam_link_active test.temporary matches 1 run scoreboard players operation #beam_link_timer test.temporary -= #beam_link_delta test.temporary

execute if score #beam_link_active test.temporary matches 1 if score #beam_link_timer test.temporary matches ..0 run function test:magic/beam/link/emit
execute if score #beam_link_active test.temporary matches 1 if score #beam_link_timer test.temporary matches ..0 run scoreboard players remove #beam_link_count test.temporary 1
execute if score #beam_link_active test.temporary matches 1 if score #beam_link_timer test.temporary matches ..0 store result score #beam_link_timer test.temporary run data get storage test: link_work.template.interval_ticks

execute if score #beam_link_active test.temporary matches 1 store result storage test: link_state_work.count int 1 run scoreboard players get #beam_link_count test.temporary
execute if score #beam_link_active test.temporary matches 1 store result storage test: link_state_work.timer int 1 run scoreboard players get #beam_link_timer test.temporary

data modify storage test: link_work.states append from storage test: link_state_work
