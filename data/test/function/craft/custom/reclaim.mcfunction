#> test:craft/custom/reclaim
# 実行位置 = 樽。@macro pred/count/name: 取り返すもの。結果を取ったのと同じtickに材料が抜かれ、材料を使わずに結果が渡ってしまった。
# 近くのプレイヤーの持ち物とカーソルから(26.3の clear はカーソルの上のアイテムにも効く)、足りなければ近くに落ちているものから消す。
# 同じものをもともと持っていた場合は、そちらが減ることもある(結果として増えなければよい)

$execute store result score #cc_got test.temporary run clear @p[distance=..6] $(pred) $(count)
$scoreboard players set #cc_left test.temporary $(count)
scoreboard players operation #cc_left test.temporary -= #cc_got test.temporary
$execute if score #cc_left test.temporary matches 1.. as @e[type=item,distance=..8] if items entity @s contents $(pred) run tag @s add cc_reclaim
execute if score #cc_left test.temporary matches 1.. run function test:craft/custom/reclaim_drop
tag @e[type=item,tag=cc_reclaim] remove cc_reclaim
tellraw @p[distance=..6] {text:"材料が足りない",color:"red"}
$function test:debug/log {msg:"クラフト: $(name) を取り返した(材料が足りない)"}
