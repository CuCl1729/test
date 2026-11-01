# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:talk/generated/node/elder_after
# 会話のノード「elder_after」(スプレッドシートの「会話」タブ)。@s = 話しかけた人、実行位置 = NPC

function test:talk/begin {node:"elder_after"}
tellraw @s ""
tellraw @s [{text:"[村長] ",color:"yellow"},{text:"決めたとおりに、村は動き始めておる。",color:"white"}]
function test:talk/finish
