# @s = 番号が一致したプレイヤー。手に取った枠を空けてから一度だけ処理する。
execute if score #station_claimed test.temporary matches 1 run return 0
scoreboard players set #station_claimed test.temporary 1
$item replace entity @s $(dest) with air
$function test:$(call) with storage test: station_action.args
