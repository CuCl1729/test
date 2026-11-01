#> test:npc/cart/bank/tick
# @s = 銀行のトロッコ(test:npc/cart/cart_tick から毎tick。持ち主は tag=npc_cart_owner)。預ける枠 0〜17 に置かれたコインを持ち主の口座に入れ、
# コイン以外は持ち主に返す。UI のアイテムは 18〜26 の9個なので、それより多いときだけ枠を見る

execute store result score #bi test.temporary run data get entity @s Items
execute if score #bi test.temporary matches ..9 run return 0
scoreboard players set #bd test.temporary 0
function test:npc/cart/bank/slot {slot:0}
function test:npc/cart/bank/slot {slot:1}
function test:npc/cart/bank/slot {slot:2}
function test:npc/cart/bank/slot {slot:3}
function test:npc/cart/bank/slot {slot:4}
function test:npc/cart/bank/slot {slot:5}
function test:npc/cart/bank/slot {slot:6}
function test:npc/cart/bank/slot {slot:7}
function test:npc/cart/bank/slot {slot:8}
function test:npc/cart/bank/slot {slot:9}
function test:npc/cart/bank/slot {slot:10}
function test:npc/cart/bank/slot {slot:11}
function test:npc/cart/bank/slot {slot:12}
function test:npc/cart/bank/slot {slot:13}
function test:npc/cart/bank/slot {slot:14}
function test:npc/cart/bank/slot {slot:15}
function test:npc/cart/bank/slot {slot:16}
function test:npc/cart/bank/slot {slot:17}
execute if score #bd test.temporary matches 1.. run function test:npc/cart/bank/deposited
