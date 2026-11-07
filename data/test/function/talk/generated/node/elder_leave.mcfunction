# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:talk/generated/node/elder_leave
# 会話のノード「elder_leave」(スプレッドシートの「会話」タブ)。@s = 話しかけた人、実行位置 = NPC

function test:talk/begin {node:"elder_leave"}
function test:talk/skip_stop
execute unless entity @s[tag=talk_skipping] run tellraw @s ""
execute unless entity @s[tag=talk_skipping] run tellraw @s [{text:"村長はゆっくりとうなずいた。",color:"gray"}]
function test:talk/finish
