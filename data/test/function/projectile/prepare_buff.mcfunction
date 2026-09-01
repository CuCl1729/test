#> test:projectile/prepare_buff
# @s = 投射体。詠唱時に持たせたバフ一覧(data.buff)を、敵向け・味方向けに振り分ける
#
# 着弾は詠唱の数tick後になり、storage test: magic.player は別の魔法で上書きされている
# 可能性があるため直接は見ない(詠唱者を引くためのtest.ownerと同じ理由で、投射体自身に運ばせている)

data modify storage test: magic_buff.src set value []
execute if data entity @s data.buff[0] run data modify storage test: magic_buff.src set from entity @s data.buff

function test:magic/buff/prepare
