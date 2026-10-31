#> test:crop/token/give_item
# @s = プレイヤー。@macro item/count: 渡すアイテムと個数

$give @s $(item) $(count)
$function test:debug/log {msg:" $(item) x$(count)"}
