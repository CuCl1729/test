#> test:magic/combo/behavior/self_sustain
# @s = 持ち主。自分に掛かり続ける。
# バフ/デバフは継続時間・重ねがけ・掛け直しの仕組みをバフ側が既に持っているので、掛けるのは1回だけ
# (= 今までの自己魔法と同じ。毎パルス掛け直すと段数が毎秒増えてしまう)。
# 毎パルス効く回復だけを、続く時間ぶん繰り返す
function test:magic/self/cast
execute if data storage test: magic.player.heal run function test:magic/cont/self_spawn
