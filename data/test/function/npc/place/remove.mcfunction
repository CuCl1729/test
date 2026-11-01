#> test:npc/place/remove
# @s = NPC のインタラクション(実行位置も @s)。@macro id: NPC id。同じ所の見た目と一緒に消える

$kill @e[tag=npc_body,tag=npc.$(id),distance=..1]
kill @s
