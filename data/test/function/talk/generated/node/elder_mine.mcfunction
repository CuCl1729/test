# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:talk/generated/node/elder_mine
# 会話のノード「elder_mine」(スプレッドシートの「会話」タブ)。@s = 話しかけた人、実行位置 = NPC

execute unless function test:talk/party_ready run return run function test:talk/not_ready
function test:talk/begin {node:"elder_mine"}
function test:talk/skip_stop
execute unless entity @s[tag=talk_skipping] run tellraw @a[distance=..16] ""
execute unless entity @s[tag=talk_skipping] run tellraw @a[distance=..16] [{text:"[村長] ",color:"yellow"},{text:"鉱山を広げるのじゃな。皆に伝えよう。",color:"white"}]
function test:talk/generated/act/a4
function test:talk/finish
