#> test:magic/crafter/stage_step
# @s = クラフター本体。@macro stage_id: 読んだ要素id(ほかのキーも渡ってくるが使わない)
$execute if data storage test: asset.magic.types[{id:"$(stage_id)",role:"link"}] run return run function test:magic/crafter/stage_link {id:"$(stage_id)"}
$data modify storage test: registry_work.stage_ids append value "$(stage_id)"
