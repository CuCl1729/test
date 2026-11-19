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
# 次の段が持続物(自動ビーム)を出すとき、それを「この発生源に乗せる」ために目印を付けておく
# (発生源が動けば一緒に動き、発生源が消えたら持続物も終わる)
tag @s add chain_carrier
# 持続物から起きた段にルート元帳のidを引き継ぐ(無ければ未追跡のまま)
data remove storage test: chain_work.root
execute if data entity @s data.magic_root run data modify storage test: chain_work.root set from entity @s data.magic_root
# 同じ発生源から生まれた複数の子が枠を奪い合わないよう、この個体専用の発生源IDを割り当てる
execute if data storage test: chain_work.root run function test:magic/root/source_self
execute if data storage test: chain_work.root if score #root_self_source test.temporary matches 1.. run data modify storage test: chain_work.root.source set from entity @s data.magic_source
execute if data storage test: chain_work.root unless data storage test: chain_work.root.source run data modify storage test: chain_work.root.source set value 0
# 確定ビームの待ち行列経由で使われた古い fixed_origin が残っていないようにする(物理の持続は発生源に乗って追う)
data remove storage test: chain_work.fixed_origin
data remove storage test: chain_work.action
execute if data entity @s data.action run data modify storage test: chain_work.action set from entity @s data.action
execute as @a[tag=chain_owner,limit=1] run function test:magic/chain/start
tag @s remove chain_carrier
tag @a remove chain_owner
