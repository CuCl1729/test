# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:talk/generated/node/herb_hello
# 会話のノード「herb_hello」(スプレッドシートの「会話」タブ)。@s = 話しかけた人、実行位置 = NPC

function test:talk/begin {node:"herb_hello"}
tellraw @s ""
tellraw @s [{text:"[薬師] ",color:"yellow"},{text:"薬草のことなら任せて。",color:"white"}]
function test:talk/finish
