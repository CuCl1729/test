# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:talk/generated/node/herb_wait
# 会話のノード「herb_wait」(スプレッドシートの「会話」タブ)。@s = 話しかけた人、実行位置 = NPC

function test:talk/begin {node:"herb_wait"}
tellraw @s ""
tellraw @s [{text:"[薬師] ",color:"yellow"},{text:"ゴブリンを倒して、薬草を3つ持ってきてね。",color:"white"}]
function test:talk/finish
