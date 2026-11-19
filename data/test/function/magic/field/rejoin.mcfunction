#> test:magic/field/rejoin
# @s = ログインし直したプレイヤー。中に居るあいだにオフラインで片付けられなかった場のバフ/デバフ
# (test:field_cleanup に積んである自分の持ち分)を、まとめて外す。他の人・他の場の分はそのまま残り、
# 実際に受けている段数・残り時間もその分だけ正しく減る。通常のバフの時間経過はここでは進めない
execute unless score @s test.magic.eid matches 1.. run return 0
execute store result storage test: field_work.rejoin.e int 1 run scoreboard players get @s test.magic.eid
function test:magic/field/cleanup_drain with storage test: field_work.rejoin
