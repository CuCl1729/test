#> test:machine/place_locked
# @s = エッグで置かれた機械のマーカー(test:trigger/place から。oh_my_dat は置いたプレイヤーを指している)。@macro id: 機械の種類。
# 置いた人がこの機械を研究で解放していなければ、エッグを返して「未研究」と出し、すぐ消える

$execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.unlock.machine.$(id) run return 0
$function test:machine/give_egg {id:"$(id)"}
tellraw @p[distance=..8] {text:"未研究",color:"red"}
kill @s
