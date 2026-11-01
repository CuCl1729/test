# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:talk/generated/node/elder_village2
# 会話のノード「elder_village2」(スプレッドシートの「会話」タブ)。@s = 話しかけた人、実行位置 = NPC

function test:talk/begin {node:"elder_village2"}
tellraw @s ""
tellraw @s [{text:"[",color:"aqua"},{selector:"@s",color:"aqua"},{text:"] ",color:"aqua"},{text:"なるほど。",color:"white"}]
function test:talk/btn {i:1,label:"次へ",node:"elder_bye"}
function test:talk/finish
