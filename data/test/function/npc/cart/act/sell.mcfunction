#> test:npc/cart/act/sell
# @s = [売る] を取ったプレイヤー(売る人)。@macro cart/npc: トロッコの持ち主の番号と店員。売る枠のうち、この店が買い取るものを全部売って
# 売る人の口座に入れる。余りと、買い取らないものは、売る人に返す

tag @s add npc_cart_clicker
scoreboard players set #sell_g test.temporary 0
scoreboard players set #sell_n test.temporary 0
$execute as @e[type=chest_minecart,tag=npc_cart] if score @s test.npc.cart_owner matches $(cart) at @s run function test:npc/cart/shop/sell_run {npc:"$(npc)"}
tag @s remove npc_cart_clicker
execute if score #sell_n test.temporary matches 0 run return run tellraw @s {text:"売れるものが無い",color:"gray"}
execute store result storage test: money_work.n int 1 run scoreboard players get #sell_g test.temporary
function test:money/add with storage test: money_work
tellraw @s [{text:"×",color:"gray"},{score:{name:"#sell_n",objective:"test.temporary"},color:"white"},{text:" を ",color:"gray"},{score:{name:"#sell_g",objective:"test.temporary"},color:"yellow"},{text:"G で売った",color:"gray"}]
