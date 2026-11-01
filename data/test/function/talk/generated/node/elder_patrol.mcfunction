# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:talk/generated/node/elder_patrol
# 会話のノード「elder_patrol」(スプレッドシートの「会話」タブ)。@s = 話しかけた人、実行位置 = NPC

function test:talk/begin {node:"elder_patrol"}
tellraw @s ""
tellraw @s [{text:"[村長] ",color:"yellow"},{text:"村の外れを見てきてくれんか。",color:"white"}]
function test:talk/generated/act/a1
function test:talk/finish
