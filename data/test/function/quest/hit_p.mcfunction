#> test:quest/hit_p
# @s = プレイヤー。oh_my_dat を @s に向けてから、数を1増やす(@macro id/stage/need は test:quest/hit と同じ)

function #oh_my_dat:please
$function test:quest/hit {id:"$(id)",stage:$(stage),need:$(need),add:1}
