#> test:job/reset/request
# @s = [スキルをリセット]を押したプレイヤー。@macro job/station: 職業id・ステーションのUUID。
# 確認待ち(test.job.reset = {job, station, seq})を記録し、内容と[実行][キャンセル]を本人だけに出す。
# 押し直すと番号が変わり、前の確認ボタンは効かなくなる

function #oh_my_dat:please
execute if score @s test.battle.id matches 1.. run return run tellraw @s {text:"戦闘中はリセットできない",color:"red"}
$execute unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.unlocked.$(job) run return run tellraw @s {text:"未解放の職業",color:"red"}

scoreboard players add #job_reset_seq test.time 1
data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.reset set value {}
$data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.reset.job set value "$(job)"
$data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.reset.station set value $(station)
execute store result storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.reset.seq int 1 run scoreboard players get #job_reset_seq test.time
tag @s add job_reset_pending

data modify storage test: job_work.reset_names set value []
$data modify storage test: job_work.reset_queue set from storage test: asset.job.jobs[{id:"$(job)"}].skills
$function test:job/reset/names_loop {job:"$(job)"}
execute unless data storage test: job_work.reset_names[0] run data modify storage test: job_work.reset_names append value "なし"

$execute store result score #reset_point test.temporary run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.$(job).level
scoreboard players remove #reset_point test.temporary 1

tellraw @s ""
$tellraw @s [{text:"スキルのリセット: ",color:"gold"},{nbt:'asset.job.jobs[{id:"$(job)"}].label',storage:"test:",interpret:true,color:"white"}]
tellraw @s [{text:"解除: ",color:"gray"},{nbt:"job_work.reset_names[]",storage:"test:",interpret:true,separator:"、",color:"white"}]
tellraw @s [{text:"リセット後のポイント: ",color:"gray"},{score:{name:"#reset_point",objective:"test.temporary"},color:"white"}]

scoreboard players operation #reset_v test.temporary = #job_reset_seq test.time
scoreboard players operation #reset_v test.temporary *= #10 test.constant
data modify storage test: job_work.reset_btn set value {ok:0,no:0}
execute store result storage test: job_work.reset_btn.ok int 1 run scoreboard players add #reset_v test.temporary 1
execute store result storage test: job_work.reset_btn.no int 1 run scoreboard players add #reset_v test.temporary 1
function test:job/reset/buttons with storage test: job_work.reset_btn
scoreboard players set @s test.job_reset 0
scoreboard players enable @s test.job_reset
