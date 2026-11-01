#> test:craft/custom/return_slot
# @s = マーカー(実行位置は樽)。結果の枠にあるもの(craft_work.now)を樽から消し、近くのプレイヤーの足元に渡す。
# プレイヤーが置いたもの、または結果を一部だけ取ったときの残り(残りも取ったものとして扱う)

data modify storage test: loot.item set from storage test: craft_work.now
data remove block ~ ~ ~ Items[{Slot:16b}]
execute as @p[distance=..6] at @s run function test:item/drop_at
