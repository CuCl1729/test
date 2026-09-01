scoreboard players reset @s test.repeat
execute if data storage test: {magic:{player:{effect:["heal"]}}} run function test:magic/effect/heal

# 選んだバフを自分に付与する。自己タイプは支援系の効果しか組み合わせられないため、
# 敵味方の振り分け(magic/buff/prepare)は挟まずそのまま全部自分に掛ける
execute if data storage test: magic.player.buff[0] run data modify storage test: buff_work.pending set from storage test: magic.player.buff
execute if data storage test: magic.player.buff[0] run function test:buff/apply_list
