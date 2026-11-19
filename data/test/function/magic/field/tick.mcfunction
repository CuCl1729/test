#> test:magic/field/tick
# @s = 場(at @s。test:tick から毎 tick)。
#
# 出入りの反映は**毎 tick**行う(ダメージのパルスとは別の周期)。出た瞬間にその場のバフが外れ、
# パルス間隔(既定20tick)ぶん効果が残り続けることがないようにするため。
# ダメージ・回復はパルスの間隔ごと。
#
# 終わるのは次の2つだけ:
#   ・続く時間が尽きた
#   ・持ち主が使えない状態になった(死亡・ダウン・ログアウト・別の次元・ターン制の戦闘)
# 出した元(弾・設置物)が消えても場は終わらない。消えた瞬間の位置に取り残されて、
# 残りの時間ぶんその場で効き続ける(弾 →着弾で→ 継続+範囲 のように、元が即座に消える場合も同じ)
scoreboard players remove @s test.device.life 1
execute if score @s test.device.life matches ..0 run return run function test:magic/field/end

# 出した元に乗っている場は、元が消えていたら降りてその場に残る
execute if entity @s[tag=field_parented] run function test:magic/field/detach_check

execute unless function test:magic/owner/find run return run function test:magic/field/owner_gone
# 直接唱えた場・自己持続の場は持ち主について動く
execute if entity @s[tag=field_follow_owner] at @a[tag=magic_owner,limit=1] run teleport @s ~ ~ ~
tag @a remove magic_owner

data modify storage test: magic.player set from entity @s data.field

# 出入り(バフの付け外し)は毎 tick
function test:magic/field/members with storage test: magic.player.aoe

# ダメージ・回復はパルスの間隔ごと
scoreboard players remove @s test.device.timer 1
execute if score @s test.device.timer matches 1.. run return 0
execute store result score @s test.device.timer run data get storage test: magic.player.continuous.period

function test:magic/field/pulse
