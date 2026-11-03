#> test:magic/crafter/stage_chain_loop
# registry_work.chain_src(2段目以降)を前から magic.loot.status.chain = [{link, link_params, stage}] に積む
execute unless data storage test: registry_work.chain_src[0] run return 0
data modify storage test: magic.loot.status.chain append value {link:"",link_params:{},stage:{}}
data modify storage test: magic.loot.status.chain[-1].link set from storage test: registry_work.chain_src[0].link
data modify storage test: magic.loot.status.chain[-1].link_params set from storage test: registry_work.chain_src[0].link_params
data modify storage test: magic.loot.status.chain[-1].stage set from storage test: registry_work.chain_src[0].status
data remove storage test: registry_work.chain_src[0]
function test:magic/crafter/stage_chain_loop
