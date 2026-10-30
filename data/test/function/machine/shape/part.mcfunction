#> test:machine/shape/part
# @s = 機械のマーカー(実行位置は核の中心)。@macro x/y/z: 核からのずれ。その位置が搬入口・搬出口・筐体のどれかを調べる。
# どれでもなければ「足りない」として数え、位置を machine_work.missing に足す(ゴーストを出す位置)

$execute positioned ~$(x) ~$(y) ~$(z) if block ~ ~ ~ #test:machine_inputs run return run function test:machine/shape/input {x:$(x),y:$(y),z:$(z)}
$execute positioned ~$(x) ~$(y) ~$(z) if block ~ ~ ~ #test:machine_outputs run return run function test:machine/shape/output {x:$(x),y:$(y),z:$(z)}
$execute positioned ~$(x) ~$(y) ~$(z) if block ~ ~ ~ #test:machine_casings run return run function test:machine/shape/casing
scoreboard players add #machine_missing test.temporary 1
$data modify storage test: machine_work.missing append value {x:$(x),y:$(y),z:$(z)}
