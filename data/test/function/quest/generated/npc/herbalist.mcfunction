# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:quest/generated/npc/herbalist
# NPC「herbalist」に話しかけたときに進む段階(会話の前。@s = 話しかけた人)

function test:quest/deliver_hit {id:"herb",stage:2,need:3,main:0b,pred:"*[minecraft:custom_data~{test:{material:{kind:\"herb_leaf\"}}}]"}
