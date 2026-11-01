#> test:npc/place/check
# @s = NPC のインタラクション(実行位置も @s)。@macro id: NPC id。一覧から消えたか、定義が変わっていれば片付ける(次の置き直しで置かれる)

$execute unless data storage test: asset.npc.$(id) run return run function test:npc/place/remove {id:"$(id)"}
$data modify storage test: npc_work.cmp set from storage test: asset.npc.$(id)
execute store success score #npc_diff test.temporary run data modify storage test: npc_work.cmp set from entity @s data.npc.def
$execute if score #npc_diff test.temporary matches 1 run function test:npc/place/remove {id:"$(id)"}
