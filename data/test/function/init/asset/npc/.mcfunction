#> test:init/asset/npc/
# NPC のレジストリ(スプレッドシートの「NPC」タブから生成)。asset.npc.<id> と asset.npc_ids

data modify storage test: asset.npc set value {}
data modify storage test: asset.npc_ids set value []
function test:init/asset/npc/generated/npcs
