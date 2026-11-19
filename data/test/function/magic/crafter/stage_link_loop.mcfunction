#> test:magic/crafter/stage_link_loop
# registry_work.link_after.list を1つずつ見て、閉じたばかりの段の形態と合うものがあれば #link_ok を立てる
execute unless data storage test: registry_work.link_after.list[0] run return 0

data modify storage test: registry_work.link_after.one set from storage test: registry_work.link_after.list[0]
data remove storage test: registry_work.link_after.list[0]
function test:magic/crafter/stage_link_one with storage test: registry_work.link_after

function test:magic/crafter/stage_link_loop
