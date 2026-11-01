#> test:npc/cart/player
# @s = 店員・銀行員(tag=npc_counter)の6ブロック以内にいるプレイヤー(test:tick から毎tick。実行位置も @s)。
# 目線の先(4.5ブロックまで)が店員・銀行員なら、頭の位置にその店・銀行のトロッコを出して付いてこさせる(右クリックで画面が開く)。
# スニーク中は出さない(Shift+右クリックがトロッコに邪魔されず NPC に届き、会話できるように)。目線が10tick続けて外れたら片付ける

function #oh_my_dat:please
scoreboard players operation #pid test.temporary = @s test.pid
tag @e[type=chest_minecart,tag=npc_cart_mine] remove npc_cart_mine
execute as @e[type=chest_minecart,tag=npc_cart] if score @s test.npc.cart_owner = #pid test.temporary run tag @s add npc_cart_mine
execute if predicate test:sneaking run return run function test:npc/cart/remove_mine

scoreboard players set #gz_ray test.temporary 45
execute anchored eyes positioned ^ ^ ^ anchored feet run function test:npc/gaze/ray
execute unless entity @e[type=interaction,tag=npc_gaze,limit=1] run return run function test:npc/cart/lost
scoreboard players set @s test.npc.cart_lost 0
data modify storage test: cart_work.hit set value {npc:""}
data modify storage test: cart_work.hit.npc set from entity @n[type=interaction,tag=npc_gaze] data.npc.id
tag @e[type=interaction,tag=npc_gaze] remove npc_gaze

execute unless entity @e[type=chest_minecart,tag=npc_cart_mine,limit=1] run function test:npc/cart/summon
# 別の店員・銀行員に目線を移したら、中身を入れ替える
data modify storage test: cart_work.cmp set value ""
data modify storage test: cart_work.cmp set from storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.cart.npc
execute store success score #cart_changed test.temporary run data modify storage test: cart_work.cmp set from storage test: cart_work.hit.npc
execute if score #cart_changed test.temporary matches 1 run function test:npc/cart/switch
function test:npc/cart/follow
