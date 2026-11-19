#> test:magic/beam/tick
# @s = ビームを出しているプレイヤー(at @s。test:tick から毎 tick)。
# 押すのをやめた・唱えられない状態になった・MPが尽きたら止める。
#
# 請求するのは「押していたと記録された tick の回数ぶん」だけ(test.magic.held を数え、
# 請求済みの回数 test.magic.billed との差を払う)。時刻の差で当てないので、
# 右クリックの検知と test:tick のどちらが先に走る版でも、離した後に余分に請求しない。
# 同じ tick に二度請求することもない(差が0なら何もしない)。
#
# ダメージは「間隔を丸ごと押し続けた後」に出る。押した瞬間に1回出すと、連打で1 tickごとに
# 1パルスぶんのダメージを撒けてしまうため。線(見た目と壁の判定)は毎 tick 描く
function #oh_my_dat:please

# ジョブのビームは専用の仮想入力を毎tick通す。解禁解除・リセット・ノード種別の変更で続けられなくなったら、
# 下の間隔(gap)判定より先にここで止める。アイテムのビームはこの入力を使わないので従来のまま
scoreboard players set #job_beam_hold_ok test.temporary 1
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.beam.data.job_skill store result score #job_beam_hold_ok test.temporary run function test:job/skill/magic/hold with storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.beam.data.job_skill
execute if score #job_beam_hold_ok test.temporary matches 0 run return run function test:magic/beam/stop

# 離した(押し続けの記録が 3 tick 以上古い)。見た目の猶予のため少し待つが、請求は下の回数差で行う
execute store result score #beam_now test.temporary run time query gametime
scoreboard players operation #beam_gap test.temporary = #beam_now test.temporary
scoreboard players operation #beam_gap test.temporary -= @s test.magic.hold
execute if score #beam_gap test.temporary matches 3.. run return run function test:magic/beam/stop

# ターン制の戦闘に入った・倒れた・HPが尽きた(どれも魔法を唱えられない状態)
execute if score @s test.battle.id matches 1.. run return run function test:magic/beam/stop
execute if entity @s[tag=downed] run return run function test:magic/beam/stop
execute if score @s test.status.hp matches ..0 run return run function test:magic/beam/stop

# 唱えたときの内容を個別ストレージから読み直す(storage test: magic.player はほかの魔法で上書きされている)
data modify storage test: magic.player set from storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.beam

# ワールドを跨いだ(ポータル等)後の古いビーム・失効した発動ルートに乗ったままの古いビームは、
# 実体の弾や線を出す前に止める(関数呼び出しに with storage は使えないので、結果をスコアに受ける)
execute store result score #beam_dimension_ok test.temporary run function test:magic/beam/same_dimension with storage test: magic.player
execute if score #beam_dimension_ok test.temporary matches 0 run return run function test:magic/beam/stop

scoreboard players set #beam_held_ok test.temporary 1
execute if data storage test: magic.player.root store result score #beam_held_ok test.temporary run function test:magic/beam/root/is_held with storage test: magic.player.root
execute if score #beam_held_ok test.temporary matches 0 run return run function test:magic/beam/stop

# まだ請求していない「押していた tick」の回数
execute unless score @s test.magic.held matches -2147483648..2147483647 run scoreboard players set @s test.magic.held 0
execute unless score @s test.magic.billed matches -2147483648..2147483647 run scoreboard players set @s test.magic.billed 0
scoreboard players operation #beam_owed test.temporary = @s test.magic.held
scoreboard players operation #beam_owed test.temporary -= @s test.magic.billed

# この tick は検知が来ていない(離した直後の猶予)。線だけ描いて、請求もダメージも進めない
execute if score #beam_owed test.temporary matches ..0 run scoreboard players set #beam_apply test.temporary 0
execute if score #beam_owed test.temporary matches ..0 run return run function test:magic/beam/render

# 押していた回数ぶんの維持MP。払えなければ線も出さずに止める(MPが無いのにダメージが出ないように)
execute unless function test:magic/beam/upkeep run return run function test:magic/beam/stop
scoreboard players operation @s test.magic.billed = @s test.magic.held

# ダメージを与えるのはパルスの間隔ごと。押していた回数ぶん進める
scoreboard players operation @s test.device.timer -= #beam_owed test.temporary
scoreboard players set #beam_apply test.temporary 0
execute if score @s test.device.timer matches ..0 run scoreboard players set #beam_apply test.temporary 1
execute if score #beam_apply test.temporary matches 1 store result score @s test.device.timer run data get storage test: magic.player.continuous.period

execute if score #beam_apply test.temporary matches 0 run return run function test:magic/beam/render

function test:magic/prepare_damage
function test:magic/beam/prepare
tag @s add damage_attacker
function test:magic/beam/render
tag @s remove damage_attacker
tag @e remove beam_hit
