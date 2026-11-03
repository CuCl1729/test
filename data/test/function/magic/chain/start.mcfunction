#> test:magic/chain/start
# @s = 持ち主のプレイヤー。実行位置 = この段を始める所。chain_work.next = {link, link_params, stage}、chain_work.rest = その後の段。
# この段を、唱えたときと同じく magic.player にして威力を用意し(MP は唱えたときに全段ぶん払ってある)、形態ごとに始める
function #oh_my_dat:please
data modify storage test: magic.player set from storage test: chain_work.next.stage
execute if data storage test: chain_work.rest[0] run data modify storage test: magic.player.chain set from storage test: chain_work.rest
execute if data storage test: chain_work.uid run data modify storage test: magic.player.uid set from storage test: chain_work.uid
execute if data storage test: chain_work.cast run data modify storage test: magic.player.cast set from storage test: chain_work.cast
function test:magic/prepare_damage
function test:magic/chain/form with storage test: magic.player
