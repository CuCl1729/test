#> test:station/give_egg
# @s = 渡す位置(ステーションのマーカーやプレイヤー)。@macro id: ステーションの種類。
# 使うとその場にステーションを置けるスポーンエッグを渡す(置いたときは test:trigger/place → test:station/place)

$function test:station/build_egg {id:"$(id)"}
function test:loot/give
