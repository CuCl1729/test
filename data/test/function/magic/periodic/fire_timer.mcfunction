#> test:magic/periodic/fire_timer
# @s = 一定間隔の発生源(at @s)。間隔を入れ直してから次の段を起こす
# (作成時に計算済みのtick数をそのまま使う。持ち主のスコアがその後に変わっても入れ直さない)
execute store result score @s test.device.timer run data get entity @s data.periodic.interval_ticks
function test:magic/periodic/fire
