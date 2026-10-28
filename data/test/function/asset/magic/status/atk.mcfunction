# @macro cost/per_stack/max_stacks: 1段ごとのコスト・威力(攻撃力に対する倍率、1000で×10)・最大段数(「魔法の数値」タブ)。
# クラフト中に使われた威力上昇素材の個数を数え、max_stacks個まで重ねがけする(#atk_stackはtest:asset/magic/resetで
# クラフト開始時に0リセットされる。上限を超えた分は無視してコストも取らない)。
# 加算するかどうかを先に確定させてから増やす(先に#atk_stackを増やすと、上限の段のコストが取れなくなるため)
scoreboard players set #atk_apply test.temporary 0
$execute unless score #atk_stack test.temporary matches $(max_stacks).. run scoreboard players set #atk_apply test.temporary 1
execute if score #atk_apply test.temporary matches 1 run scoreboard players add #atk_stack test.temporary 1
$execute if score #atk_apply test.temporary matches 1 run scoreboard players add #cost test.temporary $(cost)

scoreboard players operation #atk_value test.temporary = #atk_stack test.temporary
$scoreboard players set #atk_per_stack test.temporary $(per_stack)
scoreboard players operation #atk_value test.temporary *= #atk_per_stack test.temporary
execute store result storage test: magic.loot.status.data.magic.fire.atk int 1 run scoreboard players get #atk_value test.temporary
