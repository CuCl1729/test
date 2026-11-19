#> test:magic/cont/self_spawn
# @s = 持ち主。自己持続の印を置く。持ち主について回り、パルスごとに持ち主を回復する。
# 持ち主が居なくなったら(ログアウト・次元移動・死亡)終わる
scoreboard players operation #sustain_owner test.temporary = @s OhMyDatID

# 同時に存在できる数の上限(つなぎ「一定間隔」の max_alive)。達していたら新しくは出さない
function test:magic/cont/cap
execute if score #cont_over test.temporary matches 1 run return 0
execute unless function test:magic/root/commit run return 0

summon armor_stand ~ ~ ~ {Tags:["magic_sustain","sustain_new"],Marker:1b,Invisible:1b,NoGravity:1b,Invulnerable:1b,Small:1b}
data modify entity @n[type=armor_stand,tag=sustain_new] data.sustain set from storage test: magic.player
scoreboard players operation @n[type=armor_stand,tag=sustain_new] test.owner = #sustain_owner test.temporary
# 同時に存在できる数を数えるとき、同じ魔法のものだけを数えるために覚えさせる(test:magic/cont/cap)
scoreboard players set @n[type=armor_stand,tag=sustain_new] test.magic_uid 0
execute store result score @n[type=armor_stand,tag=sustain_new] test.magic_uid run data get storage test: magic.player.uid
execute store result score @n[type=armor_stand,tag=sustain_new] test.device.life run data get storage test: magic.player.continuous.duration 20
scoreboard players set @n[type=armor_stand,tag=sustain_new] test.device.timer 0
execute if data storage test: magic.player.root as @n[type=armor_stand,tag=sustain_new] run function test:magic/root/retain with storage test: magic.player.root
tag @n[type=armor_stand,tag=sustain_new] remove sustain_new
