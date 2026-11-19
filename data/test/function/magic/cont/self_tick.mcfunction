#> test:magic/cont/self_tick
# @s = 自己持続の印(at @s。test:tick から毎 tick)。
# 持ち主が使えない状態(死亡・ダウン・ログアウト・別の次元・ターン制の戦闘)になったら終わる。
# パルスの間隔ごとに持ち主を回復する
scoreboard players remove @s test.device.life 1
execute if score @s test.device.life matches ..0 run return run function test:magic/root/kill

execute unless function test:magic/owner/find run return run function test:magic/cont/self_end

scoreboard players remove @s test.device.timer 1
execute if score @s test.device.timer matches 1.. run return run tag @a remove magic_owner

data modify storage test: magic.player set from entity @s data.sustain
execute store result score @s test.device.timer run data get storage test: magic.player.continuous.period

# 1秒あたりの数値を1パルスぶんに縮める(回復量を縮めるために通す)
function test:magic/cont/scale with storage test: magic.player.continuous

execute as @a[tag=magic_owner,limit=1] run scoreboard players reset @s test.repeat
execute as @a[tag=magic_owner,limit=1] run function test:magic/effect/heal
tag @a remove magic_owner
