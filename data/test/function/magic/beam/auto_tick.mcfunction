#> test:magic/beam/auto_tick
# @s = 自動ビーム(at @s。test:tick から毎 tick)。
# 終わるのは、続く時間が尽きた / 出した元が消えた / 持ち主が使えない状態になった のいずれか。
# 場と違ってビームは元と一緒に終わる(根元の無いビームは残さない)。
# 追尾なら相手の方へ 1 tick ぶん回る。線は毎 tick 描き、ダメージはパルスの間隔ごとに与える
scoreboard players remove @s test.device.life 1
execute if score @s test.device.life matches ..0 run return run function test:magic/root/kill

# 出した元に乗って出たビームは、元が消えたら終わる(弾が着弾した・設置物が消えた)。
# 乗っているかは execute on vehicle で調べる(乗り物が無ければそのコマンドは走らない)
execute if entity @s[tag=beam_parented] run function test:magic/beam/parent_check
execute if entity @s[tag=kill] run return 0

execute unless function test:magic/owner/find run return run function test:magic/beam/owner_gone
tag @a remove magic_owner

execute if data entity @s data.homing run function test:magic/homing/tick with entity @s data.homing

data modify storage test: magic.player set from entity @s data.beam

# ダメージを与えるのはパルスの間隔ごと。線(見た目と壁の判定)は毎 tick 描く
scoreboard players remove @s test.device.timer 1
scoreboard players set #beam_apply test.temporary 0
execute if score @s test.device.timer matches ..0 run scoreboard players set #beam_apply test.temporary 1
execute if score #beam_apply test.temporary matches 1 store result score @s test.device.timer run data get storage test: magic.player.continuous.period

execute if score #beam_apply test.temporary matches 0 run return run function test:magic/beam/render

function test:magic/beam/prepare

# ダメージ表示で持ち主を引けるようにする(弾と同じ。出た後に持ち主が居なくなっていても困らない)
scoreboard players operation #beam_owner test.temporary = @s test.owner
execute as @a if score @s OhMyDatID = #beam_owner test.temporary run tag @s add damage_attacker
function test:magic/beam/render
tag @a remove damage_attacker
tag @e remove beam_hit
