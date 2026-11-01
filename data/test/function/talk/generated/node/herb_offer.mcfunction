# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:talk/generated/node/herb_offer
# 会話のノード「herb_offer」(スプレッドシートの「会話」タブ)。@s = 話しかけた人、実行位置 = NPC

function test:talk/begin {node:"herb_offer"}
tellraw @s ""
tellraw @s [{text:"[薬師] ",color:"yellow"},{text:"薬草が足りなくて困ってるの。手伝ってくれる?",color:"white"}]
function test:talk/btn {i:1,label:"引き受ける",node:"herb_accept"}
function test:talk/btn {i:2,label:"断る",node:"herb_bye"}
function test:talk/finish
