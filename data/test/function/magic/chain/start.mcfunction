#> test:magic/chain/start
# @s = 持ち主のプレイヤー。実行位置 = この段を始める所。chain_work.next = {link, link_params, stage}、chain_work.rest = その後の段。
# この段を、唱えたときと同じく magic.player にして威力を用意し(MP は唱えたときに全段ぶん払ってある)、形態ごとに始める
function #oh_my_dat:please
data modify storage test: magic.player set from storage test: chain_work.next.stage
data remove storage test: magic.player.data.action
execute if data storage test: chain_work.action run data modify storage test: magic.player.data.action set from storage test: chain_work.action
execute if data storage test: chain_work.rest[0] run data modify storage test: magic.player.chain set from storage test: chain_work.rest
execute if data storage test: chain_work.uid run data modify storage test: magic.player.uid set from storage test: chain_work.uid
execute if data storage test: chain_work.cast run data modify storage test: magic.player.cast set from storage test: chain_work.cast
# この段を起こしたつなぎの数値も渡す(「一定間隔」の max_alive 等、起こされた側が見る値がある)
execute if data storage test: chain_work.next.link_params run data modify storage test: magic.player.link_params set from storage test: chain_work.next.link_params
# 確定ビームの待ち行列から起こされた段は、固定した地点に留まる(発生源に乗ったり持ち主を追ったりしない)
data remove storage test: magic.player.fixed_origin
execute if data storage test: chain_work.fixed_origin run data modify storage test: magic.player.fixed_origin set from storage test: chain_work.fixed_origin

# 発生源(弾・設置物)から引き継いだ発動ルートを子ステージとして載せる(未追跡なら何もしない)
data remove storage test: magic.player.root
execute if data storage test: chain_work.root run data modify storage test: magic.player.root set from storage test: chain_work.root
execute if data storage test: chain_work.root run data modify storage test: magic.player.root.child set value 1
execute if data storage test: chain_work.root run data modify storage test: magic.player.root.counted set value 0b
execute if data storage test: chain_work.root unless data storage test: magic.player.root.source run data modify storage test: magic.player.root.source set value 0

# 追跡中のルートで残りが無ければ、この段には何もさせない(消費はしない。見るだけ)
scoreboard players set #root_ok test.temporary 1
execute if data storage test: magic.player.root store result score #root_ok test.temporary run function test:magic/root/has_remaining with storage test: magic.player.root
execute if score #root_ok test.temporary matches 0 run return 0

function test:magic/prepare_damage
# 何になるかは組み合わせの表が決める(発生元 source)。設置物か弾かで向きの決め方が変わるのも表の側
function test:magic/chain/form
