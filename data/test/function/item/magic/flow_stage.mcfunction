#> test:item/magic/flow_stage
# registry_work.flow_stage(段の status)の形態の名前と、効果の名前を registry_work.flow に足す
data modify storage test: registry_work.flow_arg set value {t:""}
data modify storage test: registry_work.flow_arg.t set from storage test: registry_work.flow_stage.magic_type
function test:item/magic/flow_type with storage test: registry_work.flow_arg
execute if data storage test: registry_work.flow_stage.type_flags{aoe:1b} unless data storage test: registry_work.flow_stage{magic_type:"aoe"} run data modify storage test: registry_work.flow append value {text:"+範囲",color:"light_purple",italic:false}
data modify storage test: registry_work.flow_eq set value []
data modify storage test: registry_work.flow_eq set from storage test: registry_work.flow_stage.effect
function test:item/magic/flow_effect_loop
