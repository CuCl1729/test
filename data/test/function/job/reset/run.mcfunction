#> test:job/reset/run
# @s = [実行]を押したプレイヤー(please実行済み、確認待ちは消してある)。@macro job/station: 確認待ちに固定した職業とステーション。
# 戦闘中・未解放・ステーションから離れていれば断る。その職業の取得内容を空にし、未使用ポイントを「職業レベル−1」
# (レベル1で0、レベルアップごとに1なので獲得の総量)にする。今のコストの合計から返さないので、シートでコストが
# 変わってもポイントは増えない。レベル・経験値・解放状態・ほかの職業はそのまま

execute if score @s test.battle.id matches 1.. run return run tellraw @s {text:"戦闘中はリセットできない",color:"red"}
$execute unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.unlocked.$(job) run return run tellraw @s {text:"未解放の職業",color:"red"}
$execute unless entity @e[tag=station,distance=..6,nbt={UUID:$(station)}] run return run tellraw @s {text:"ステーションから離れている",color:"red"}

$data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.$(job).skills set value {}
$execute store result score #reset_point test.temporary run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.$(job).level
scoreboard players remove #reset_point test.temporary 1
execute if score #reset_point test.temporary matches ..-1 run scoreboard players set #reset_point test.temporary 0
$execute store result storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.data.$(job).skill_point int 1 run scoreboard players get #reset_point test.temporary
$data remove storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.job.skill_order[{job:"$(job)"}]

# パッシブと実効ステータスを組み直す(最大HP・MPが減れば今の値も切り詰める)。バンドルから消えたスキルの印は使えなくなる
function test:job/refresh_bonus
function test:job/bundle/rebuild

$tellraw @s [{text:"リセットした: ",color:"green"},{nbt:'asset.job.jobs[{id:"$(job)"}].label',storage:"test:",interpret:true,color:"white"},{text:" ポイント ",color:"gray"},{score:{name:"#reset_point",objective:"test.temporary"},color:"white"}]
# ステーションのボタンを捨てて、次のtickに描き直させる(test:job/station/main)
$execute as @e[tag=station,distance=..6,nbt={UUID:$(station)}] run data remove entity @s data.station.buttons
