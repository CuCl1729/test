# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:talk/generated/node/elder_hello
# 会話のノード「elder_hello」(スプレッドシートの「会話」タブ)。@s = 話しかけた人、実行位置 = NPC

function test:talk/begin {node:"elder_hello"}
tellraw @s ""
tellraw @s [{text:"[村長] ",color:"yellow"},{text:"ようこそ、旅の人。",color:"white"}]
function test:talk/btn {i:1,label:"村のことを聞く",node:"elder_village"}
execute if function test:talk/generated/cond/c1 run function test:talk/btn {i:2,label:"見回りを手伝う",node:"elder_patrol"}
execute if function test:talk/generated/cond/c2 run function test:talk/btn {i:3,label:"村の行く末について",node:"elder_ask"}
function test:talk/btn {i:4,label:"話を終える",node:"elder_bye"}
function test:talk/finish
