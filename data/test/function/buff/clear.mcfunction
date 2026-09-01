#> test:buff/clear
# @s = 対象。@macro reason: 終了イベントに渡す理由文字列
# 掛かっているものを全部外す(ダウン時・戦闘状態のリセット時など)

function test:buff/load
execute unless data storage test: buff_work.list[0] run return 0

$data modify storage test: buff_work.clear_reason set value "$(reason)"
function test:buff/clear_loop

function test:buff/save
function test:buff/refresh_icons

function test:buff/fire_loop
