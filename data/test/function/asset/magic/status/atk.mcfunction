# クラフト中に使われた威力上昇素材の個数を数え、3個まで重ねがけする(#atk_stackはtest:asset/magic/resetで
# クラフト開始時に0リセットされる。4個目以降は無視してコストも取らない)
execute unless score #atk_stack test.temporary matches 3 run scoreboard players add #atk_stack test.temporary 1
execute unless score #atk_stack test.temporary matches 3 run scoreboard players add #cost test.temporary 100

scoreboard players operation #atk_value test.temporary = #atk_stack test.temporary
scoreboard players operation #atk_value test.temporary *= #1000 test.constant
execute store result storage test: magic.loot.status.data.magic.fire.atk int 1 run scoreboard players get #atk_value test.temporary
