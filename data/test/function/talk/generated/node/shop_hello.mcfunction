# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:talk/generated/node/shop_hello
# 会話のノード「shop_hello」(スプレッドシートの「会話」タブ)。@s = 話しかけた人、実行位置 = NPC

function test:talk/begin {node:"shop_hello"}
tellraw @s ""
tellraw @s [{text:"[道具屋] ",color:"yellow"},{text:"いらっしゃい。品物は、こっちを見ると出るよ。",color:"white"}]
function test:talk/finish
