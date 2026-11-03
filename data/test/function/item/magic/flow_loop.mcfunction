#> test:item/magic/flow_loop
# registry_work.flow_q(chain)を前から読み、「 →つなぎ→ 」と、その段を registry_work.flow に足す
execute unless data storage test: registry_work.flow_q[0] run return 0
data modify storage test: registry_work.flow_arg set value {t:""}
data modify storage test: registry_work.flow_arg.t set from storage test: registry_work.flow_q[0].link
function test:item/magic/flow_link with storage test: registry_work.flow_arg
data modify storage test: registry_work.flow_stage set from storage test: registry_work.flow_q[0].stage
function test:item/magic/flow_stage
data remove storage test: registry_work.flow_q[0]
function test:item/magic/flow_loop
