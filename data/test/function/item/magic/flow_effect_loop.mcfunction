#> test:item/magic/flow_effect_loop
# registry_work.flow_eq(段の効果のid)を1つずつ「 <名前>」として registry_work.flow に足す
execute unless data storage test: registry_work.flow_eq[0] run return 0
data modify storage test: registry_work.flow_arg set value {t:""}
data modify storage test: registry_work.flow_arg.t set from storage test: registry_work.flow_eq[0]
function test:item/magic/flow_effect with storage test: registry_work.flow_arg
data remove storage test: registry_work.flow_eq[0]
function test:item/magic/flow_effect_loop
