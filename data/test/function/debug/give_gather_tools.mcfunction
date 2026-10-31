#> test:debug/give_gather_tools
# @s = プレイヤー。採取の道具を全種類(asset.gather_tool_ids)渡す

data modify storage test: debug_work.give_queue set from storage test: asset.gather_tool_ids
function test:debug/give_gather_tools_loop
