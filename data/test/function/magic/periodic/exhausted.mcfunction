#> test:magic/periodic/exhausted
# @s = 回数を使い切った発生源。
# 設置物と「持ち主に付いて回る印」は消える(乗っている持続物も test:tick が道連れにする)。
# 弾はそのまま飛び続ける(射程切れ・着弾で終わる)。既に出した持続物は、それぞれ自分の寿命で終わる
execute if entity @s[tag=magic_device] run tag @s add kill
execute if entity @s[tag=magic_emitter] run tag @s add kill
tag @s remove periodic
