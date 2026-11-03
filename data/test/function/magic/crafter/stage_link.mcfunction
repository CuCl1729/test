#> test:magic/crafter/stage_link
# @s = クラフター本体。@macro id: つなぎの要素id。今の段を閉じ、前の段の形態がこのつなぎの after と合うかを見て、
# つなぎの数値(magic.loot.link)と費用を取り、次の段を始める
function test:magic/crafter/stage_close

data modify storage test: registry_work.link_after set value {after:""}
$data modify storage test: registry_work.link_after.after set from storage test: asset.magic.types[{id:"$(id)"}].after
function test:magic/crafter/stage_link_check with storage test: registry_work.link_after

function test:asset/magic/reset
$function test:asset/magic/run {id:"$(id)",folder:"type"}
scoreboard players operation #cost_total test.temporary += #cost test.temporary
$data modify storage test: registry_work.stage_link set value "$(id)"
data modify storage test: registry_work.stage_link_params set value {}
data modify storage test: registry_work.stage_link_params set from storage test: magic.loot.link
