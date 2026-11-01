#> test:npc/cart/click_act
# @s = 押したプレイヤー。@macro act: 動作(test:npc/cart/act/<動作> を、印の中身 cart_work.ui で呼ぶ)

$function test:npc/cart/act/$(act) with storage test: cart_work.ui
