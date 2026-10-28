#> test:buff/on/expire/guard
# @s = バフ保持者。applyで足したぶんを戻す

$data modify storage test: buff_work.stat_arg set value {stat:"def",amount:$(amount)}
function test:buff/stat/remove with storage test: buff_work.stat_arg
