#> test:npc/interact_id
# @s = プレイヤー。@macro id: 右クリックした NPC。先にクエストの段階(この NPC と話す・納品)を進め、次に入口の条件から会話を始める

function #oh_my_dat:please
$execute if data storage test: asset.npc.$(id){hooks:1b} run function test:quest/generated/npc/$(id)
function #oh_my_dat:please
$execute if data storage test: asset.npc.$(id){entry:1b} run function test:npc/generated/entry/$(id)
