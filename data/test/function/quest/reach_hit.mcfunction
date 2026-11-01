#> test:quest/reach_hit
# @s = 範囲の中にいるプレイヤー(毎秒、test:quest/generated/reach から)。@macro id/stage/need: 場所に行く段階
# (メインは、パーティの誰か1人が入ればよい。状態は共有なので、入った人として処理する)

function #oh_my_dat:please
$function test:quest/hit {id:"$(id)",stage:$(stage),need:$(need),add:1}
