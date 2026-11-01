# ほかのアクションバー(execute store success score @s test.ui.bar_shown run title @s actionbar …)が出たら、
# 毎tickのMP表示で上書きしないように、50tick(消えるまで)待つ
execute if score @s test.ui.bar_shown matches 1 run scoreboard players set @s test.ui.bar_hold 50
scoreboard players set @s test.ui.bar_shown 0
execute if score @s test.ui.bar_hold matches 1.. run return run scoreboard players remove @s test.ui.bar_hold 1
function test:ui/status/magic
