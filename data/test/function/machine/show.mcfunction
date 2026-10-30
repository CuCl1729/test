#> test:machine/show
# @s = 形の揃った機械のマーカー。状態を表示する: 処理中なら「処理中 <進み>/<秒>」、燃料が無くて始められなければ「燃料切れ」、
# それ以外は「待機」

execute if data entity @s data.machine.processing run return run function test:machine/show_progress
execute if score #machine_no_fuel test.temporary matches 1 run return run function test:machine/status {label:"燃料切れ",color:"gold"}
function test:machine/status {label:"待機",color:"gray"}
