#> test:magic/root/burst_count
# @s = 持ち主。今回の一斉発射で実際に出す本数を、発射前にスナップショットして返す
# (元帳は変更しない。消費・出現はしない)。test.multi_shotが無ければ1、0以下も1。
# 子ステージとして数えられている場合だけ、元帳の空き枠(max_alive-alive)で切り詰める
scoreboard players set #burst_count test.temporary 1
scoreboard players operation #burst_count test.temporary = @s test.multi_shot
execute if score #burst_count test.temporary matches ..0 run scoreboard players set #burst_count test.temporary 1

execute unless data storage test: magic.player.root run return run scoreboard players get #burst_count test.temporary
# 発生源を持たない古い記録(セーブに残っていたもの)は、ここで発生源0として整えてから先へ渡す
execute unless data storage test: magic.player.root.source run data modify storage test: magic.player.root.source set value 0
execute if data storage test: magic.player.root{child:0} run return run scoreboard players get #burst_count test.temporary

return run function test:magic/root/burst_count_entry with storage test: magic.player.root
