# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:talk/generated/node/elder_village
# 会話のノード「elder_village」(スプレッドシートの「会話」タブ)。@s = 話しかけた人、実行位置 = NPC

function test:talk/begin {node:"elder_village"}
tellraw @s ""
tellraw @s [{text:"[村長] ",color:"yellow"},{text:"この村は小さいが、皆で支え合っておる。",color:"white"}]
function test:talk/btn {i:1,label:"次へ",node:"elder_village2"}
function test:talk/finish
