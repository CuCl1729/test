#> test:npc/cart/shop/buy_do
# @s = 買う人。@macro kind/id/count/buy: 品物。test:money/pay で払えれば(先に持っているコイン、足りない分を口座から)、本物を作って足元に落とす
# (持ち物がいっぱいでも落ちているので無くならない)。払えなければ「お金が足りない」

$scoreboard players set #bb test.temporary $(buy)
execute if score #bb test.temporary matches ..-1 run return 0
$execute store result score #paid test.temporary run function test:money/pay {n:$(buy)}
execute if score #paid test.temporary matches 0 run return run tellraw @s {text:"お金が足りない",color:"red"}
$function test:craft/custom/out/$(kind) {id:"$(id)"}
$data modify storage test: loot.item.count set value $(count)
execute at @s run function test:item/drop_at
$tellraw @s [{text:"買った ",color:"green"},{text:"-$(buy)G",color:"yellow"}]
