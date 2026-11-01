#> test:npc/cart/click
# @s = 店・銀行のトロッコの UI のアイテム(品物の見本・ボタン・板ガラス)を取ったプレイヤー(test:tick から)。@macro from: cursor / inv。
# 誰が押したかは「取ったアイテムを持っている人」で決める(近くに他の人がいても取り違えない)。お金や品物は @s に対して処理し、
# アイテムは手元から消して、そのトロッコ(印の cart = 持ち主の番号)を描き直す

data modify storage test: cart_work.ui set value {act:"pane",cart:0,npc:""}
$function test:npc/cart/click_read_$(from)
clear @s *[minecraft:custom_data~{test:{shop_ui:{}}}]
function #oh_my_dat:please
function test:npc/cart/click_act with storage test: cart_work.ui
function test:npc/cart/repop with storage test: cart_work.ui
