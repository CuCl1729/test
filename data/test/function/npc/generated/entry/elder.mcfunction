# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:npc/generated/entry/elder
# NPC「elder」の入口(スプレッドシートの「NPC」タブ)。@s = 話しかけた人

execute if function test:talk/generated/cond/c3 run return run function test:talk/start {npc:"elder",node:"elder_after"}
execute if function test:talk/generated/cond/c4 run return run function test:talk/start {npc:"elder",node:"elder_decide"}
function test:talk/start {npc:"elder",node:"elder_hello"}
