scoreboard players reset @s test.repeat
execute if data storage test: {magic:{player:{effect:["heal"]}}} unless function test:magic/root/commit run return 0
execute if data storage test: {magic:{player:{effect:["heal"]}}} run function test:magic/effect/heal

# 選んだバフを自分に付与する。自己タイプは支援系の効果しか組み合わせられないため、
# 敵味方の振り分け(magic/buff/prepare)は挟まずそのまま全部自分に掛ける
execute if data storage test: magic.player.buff[0] unless function test:magic/root/commit run return 0
execute if data storage test: magic.player.buff[0] run data modify storage test: buff_work.pending set from storage test: magic.player.buff
execute if data storage test: magic.player.buff[0] run function test:buff/apply_list

execute if data storage test: {magic:{player:{effect:["dash"]}}} unless function test:magic/root/commit run return 0
execute if data storage test: {magic:{player:{effect:["dash"]}}} run function test:magic/dash/start with storage test: magic.player.dash

# 一定間隔のつなぎが続くなら、持ち主に付いて回る発生源を置く(自分の今の位置から次の段を繰り返す)
data remove storage test: chain_work.peek
data modify storage test: chain_work.peek set from storage test: magic.player.chain[0]
execute if data storage test: chain_work{peek:{link:"periodic"}} run function test:magic/periodic/self_spawn
