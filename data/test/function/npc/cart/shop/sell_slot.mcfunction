#> test:npc/cart/shop/sell_slot
# @s = 店のトロッコ(test:shop/generated/sell/<店> から)。@macro slot/count/price: 売る枠と、その品物の個数・売値。
# 置いた数を個数で割った回数分を売り、#sell_g(金額)・#sell_n(売った数)に足す。余りは枠に残す(後で持ち主に返す)

$execute store result score #sc test.temporary run data get entity @s Items[{Slot:$(slot)b}].count
$scoreboard players set #sk test.temporary $(count)
scoreboard players operation #st test.temporary = #sc test.temporary
scoreboard players operation #st test.temporary /= #sk test.temporary
execute if score #st test.temporary matches ..0 run return 0
$scoreboard players set #sp test.temporary $(price)
scoreboard players operation #sp test.temporary *= #st test.temporary
scoreboard players operation #sell_g test.temporary += #sp test.temporary
scoreboard players operation #st test.temporary *= #sk test.temporary
scoreboard players operation #sell_n test.temporary += #st test.temporary
scoreboard players operation #sc test.temporary -= #st test.temporary
$execute if score #sc test.temporary matches ..0 run return run data remove entity @s Items[{Slot:$(slot)b}]
$execute store result entity @s Items[{Slot:$(slot)b}].count int 1 run scoreboard players get #sc test.temporary
