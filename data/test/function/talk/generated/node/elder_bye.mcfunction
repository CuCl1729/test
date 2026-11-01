# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:talk/generated/node/elder_bye
# 会話のノード「elder_bye」(スプレッドシートの「会話」タブ)。@s = 話しかけた人、実行位置 = NPC

function test:talk/begin {node:"elder_bye"}
tellraw @s ""
tellraw @s [{text:"[村長] ",color:"yellow"},{text:"また来なされ。",color:"white"}]
function test:talk/btn {i:1,label:"次へ",node:"elder_leave"}
function test:talk/finish
