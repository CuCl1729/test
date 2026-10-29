#> test:item/ore/give
# @s = 受け取るプレイヤー。@macro id/rare/count: 原石の種類・レア度・個数。インベントリに直接渡す
# (test:item/material/give と同じ渡し方。test:loot/give は tooltip_display を足して重ならなくなるので通さない)。
# 1スタック(64個)ずつ渡し、持ち物がいっぱいで入りきらなかった分は足元に落とす(loot give はあふれた分を消すため)

$scoreboard players set #ore_give_left test.temporary $(count)
$function test:item/ore/give_chunk {id:"$(id)",rare:$(rare)}
