#> test:magic/periodic/emit
# @s = 発生源(at @s)。次の段を1つ始める。
# test:magic/chain/next は @s の data.chain を「読むだけ」で減らさないので、
# 起動のたびに「次の段とその先の残り」の新しい複製が渡る(起こした魔法どうしは互いに干渉しない)
function test:magic/chain/next
