#> test:magic/root/can_spawn
# 今のステージ(magic.player.root)を見て、新しく持続物を出せる枠が残っているかを調べる。
# ゲートのみ(実際に出した後にtest:magic/root/retainで数える。ここで減らしたりはしない)
execute unless data storage test: magic.player.root run return 1
# 発生源を持たない古い記録(セーブに残っていたもの)は、ここで発生源0として整えてから先へ渡す
execute unless data storage test: magic.player.root.source run data modify storage test: magic.player.root.source set value 0
execute if data storage test: magic.player.root{child:0} run return 1

return run function test:magic/root/can_spawn_entry with storage test: magic.player.root
