# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:talk/generated/node/herb_thanks
# 会話のノード「herb_thanks」(スプレッドシートの「会話」タブ)。@s = 話しかけた人、実行位置 = NPC

function test:talk/begin {node:"herb_thanks"}
tellraw @s ""
tellraw @s [{text:"[薬師] ",color:"yellow"},{text:"薬草、助かったよ。",color:"white"}]
function test:talk/finish
