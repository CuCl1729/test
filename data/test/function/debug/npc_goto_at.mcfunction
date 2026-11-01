#> test:debug/npc_goto_at
# @s = プレイヤー。@macro x/y/z: NPC の座標

$execute in test:action positioned $(x) $(y) $(z) run tp @s ~0.5 ~ ~2.5
