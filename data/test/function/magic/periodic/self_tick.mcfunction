#> test:magic/periodic/self_tick
# @s = 持ち主に付いて回る発生源(at @s。test:tick から毎 tick)。
# 持ち主が使えない状態(死亡・ダウン・ログアウト・別の次元・ターン制の戦闘)になったら終わる
# (設置物は残すが、持ち主について回るものは残さないという決まり)。
# 持ち主の所へ移ってから、間隔ごとに次の段を起こす
# 片付け済み(owner/rejoinなどがこのtick中に既にkillタグを付けた)なら、tick終わりの除去より先に動いたり撃ったりしない
execute if entity @s[tag=kill] run return 0

execute unless function test:magic/owner/find run return run function test:magic/periodic/emitter_end

execute at @a[tag=magic_owner,limit=1] run teleport @s ~ ~ ~
tag @a remove magic_owner

scoreboard players remove @s test.device.timer 1
execute if score @s test.device.timer matches ..0 at @s run function test:magic/periodic/fire_timer
