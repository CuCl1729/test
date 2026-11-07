# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:talk/generated/node/herb_bye
# 会話のノード「herb_bye」(スプレッドシートの「会話」タブ)。@s = 話しかけた人、実行位置 = NPC

function test:talk/begin {node:"herb_bye"}
function test:talk/skip_stop
execute unless entity @s[tag=talk_skipping] run tellraw @s ""
execute unless entity @s[tag=talk_skipping] run tellraw @s [{text:"[薬師] ",color:"yellow"},{text:"そう…また今度ね。",color:"white"}]
function test:talk/finish
