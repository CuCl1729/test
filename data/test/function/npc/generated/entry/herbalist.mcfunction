# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:npc/generated/entry/herbalist
# NPC「herbalist」の入口(スプレッドシートの「NPC」タブ)。@s = 話しかけた人

execute if function test:talk/generated/cond/c5 run return run function test:talk/start {npc:"herbalist",node:"herb_offer"}
execute if function test:talk/generated/cond/c6 run return run function test:talk/start {npc:"herbalist",node:"herb_wait"}
function test:talk/start {npc:"herbalist",node:"herb_thanks"}
