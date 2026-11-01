# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:talk/generated/node/elder_decide
# 会話のノード「elder_decide」(スプレッドシートの「会話」タブ)。@s = 話しかけた人、実行位置 = NPC

execute unless function test:talk/party_ready run return run function test:talk/not_ready
function test:talk/begin {node:"elder_decide"}
tellraw @a[distance=..16] ""
tellraw @a[distance=..16] [{text:"[村長] ",color:"yellow"},{text:"村の行く末を、皆で決めてほしい。",color:"white"}]
function test:talk/btn {i:1,label:"森を守る",node:"elder_forest"}
function test:talk/btn {i:2,label:"鉱山を広げる",node:"elder_mine"}
function test:talk/finish
