#> test:machine/give_egg
# @s = 渡す位置(機械のマーカーやプレイヤー)。@macro id: 機械の種類。使うとその場に機械を置けるスポーンエッグを渡す
# (station/give_egg と同じ形。置いたときは test:trigger/place → test:machine/place)。
# 機械は工場(test:factory。サバイバル)の中でだけ置ける。外(アドベンチャー)ではエッグをブロックに使えず、使えても place が返す

$function test:machine/build_egg {id:"$(id)"}
function test:loot/give
