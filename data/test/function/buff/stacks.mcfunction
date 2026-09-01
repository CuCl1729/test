#> test:buff/stacks
# @s = 対象。@macro id: 調べるバフid
# 現在のスタック数を #buff_current_stacks test.buff.work に返す(掛かっていなければ0)

function test:buff/load

scoreboard players set #buff_current_stacks test.buff.work 0
$execute store result score #buff_current_stacks test.buff.work run data get storage test: buff_work.list[{id:"$(id)"}].stacks
