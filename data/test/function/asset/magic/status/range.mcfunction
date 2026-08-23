# クラフト中に使われた範囲拡大素材の個数を数え、3個まで重ねがけする(#range_stackはtest:asset/magic/reset
# でクラフト開始時に0リセットされる。4個目以降は無視してコストも取らない)
# 加算するかどうかを先に確定させてから増やす(先に#range_stackを増やしてしまうと、後続の行が
# 増やした後の値を見てしまい3段目のコストが取れなくなるため)
scoreboard players set #range_apply test.temporary 0
execute unless score #range_stack test.temporary matches 3.. run scoreboard players set #range_apply test.temporary 1

execute if score #range_apply test.temporary matches 1 run scoreboard players add #range_stack test.temporary 1

# 半径への反映は素材を置く順番に影響されないよう、ここでは#radius_bonusへ貯めるだけにして、
# 全スロットを処理し終えたtest:magic/crafter/finalizeでaoe.radiusへ合算する
execute if score #range_apply test.temporary matches 1 run scoreboard players add #radius_bonus test.temporary 2
execute if score #range_apply test.temporary matches 1 run scoreboard players add #cost test.temporary 60
