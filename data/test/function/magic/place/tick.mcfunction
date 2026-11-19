#> test:magic/place/tick
# @s = 設置物(test:tick から、at @s)。残る時間が切れたら消える。時間で / 接触で / 一定間隔 の起動を見る
# (再使用での起動は唱えたとき。test:magic/place/recast)
#
# 持ち主が使えない状態(ログアウト・死亡・ダウン・別の次元・ターン制の戦闘の中)のあいだ、
# 設置物は消さずに「全部止める」: 残る時間・次の起動までの間隔・残りの回数のどれも進めない。
# 持ち主が戻ってきたら、止めた値のまま続きから動く(居なかったぶんをまとめて起動したりはしない)
execute unless function test:magic/owner/find run return run tag @a remove magic_owner

scoreboard players remove @s test.device.life 1
execute if score @s test.device.life matches ..0 run return run function test:magic/place/expire

particle minecraft:electric_spark ~ ~0.6 ~ 0.1 0.1 0.1 0 1 normal @a

# 持ち主以外の判定(接触で)に使うため、見つけた持ち主には device_owner も付けておく
tag @a[tag=magic_owner] add device_owner

execute if entity @s[tag=device_timer] run scoreboard players remove @s test.device.timer 1
execute if entity @s[tag=device_timer] if score @s test.device.timer matches ..0 run return run function test:magic/place/fire
execute if entity @s[tag=device_touch] run function test:magic/place/touch with entity @s data
# 一定間隔(砲台): 起動しても消えず、回数を使い切るまで繰り返す
execute if entity @s[tag=device_periodic] run scoreboard players remove @s test.device.timer 1
execute if entity @s[tag=device_periodic] if score @s test.device.timer matches ..0 run function test:magic/periodic/fire_timer

tag @a remove device_owner
tag @a remove magic_owner
