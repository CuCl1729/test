# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:talk/generated/node/herb_accept
# 会話のノード「herb_accept」(スプレッドシートの「会話」タブ)。@s = 話しかけた人、実行位置 = NPC

function test:talk/begin {node:"herb_accept"}
tellraw @s ""
tellraw @s [{text:"[薬師] ",color:"yellow"},{text:"ありがとう。ゴブリンを倒してから、薬草を3つ持ってきて。",color:"white"}]
function test:talk/generated/act/a5
function test:talk/finish
