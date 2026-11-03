#> test:magic/chain/next
# @s = 段を運んでいた物(弾・設置物)。実行位置 = 次の段を始める所。
# @s の data.chain(残りの段。[0] が次)から次の段を取り出し、持ち主(test.owner = 詠唱者の OhMyDatID)として、
# この位置でその段を始める(test:magic/chain/start)。持ち主がいなければ何もしない
execute unless data entity @s data.chain[0] run return 0
data modify storage test: chain_work.rest set from entity @s data.chain
data remove storage test: chain_work.uid
data modify storage test: chain_work.uid set from entity @s data.uid
data remove storage test: chain_work.cast
data modify storage test: chain_work.cast set from entity @s data.cast
data modify storage test: chain_work.next set from storage test: chain_work.rest[0]
data remove storage test: chain_work.rest[0]
scoreboard players operation #chain_owner test.temporary = @s test.owner
execute as @a if score @s OhMyDatID = #chain_owner test.temporary run tag @s add chain_owner
execute as @a[tag=chain_owner,limit=1] run function test:magic/chain/start
tag @a remove chain_owner
