# 攻撃力上昇のバフを付与する効果。クラフト中に使われた素材の個数(戦闘中は選択回数)ぶん
# スタックが増え、3個まで重ねがけできる(#atk_up_stackはtest:asset/magic/resetで0リセットされる)
# 加算するかどうかを先に確定させてから増やす(先に増やすと後続の行が増やした後の値を見てしまうため)
scoreboard players set #atk_up_apply test.temporary 0
execute unless score #atk_up_stack test.temporary matches 3.. run scoreboard players set #atk_up_apply test.temporary 1

execute if score #atk_up_apply test.temporary matches 1 run scoreboard players add #atk_up_stack test.temporary 1
execute if score #atk_up_apply test.temporary matches 1 run scoreboard players add #cost test.temporary 120

# 付与するバフの一覧に積む。素材が2個目以降なら既にある要素のスタック数を更新する
execute unless data storage test: magic.loot.status.buff[{id:"atk_up"}] run data modify storage test: magic.loot.status.buff append value {id:"atk_up",stacks:1}
execute store result storage test: magic.loot.status.buff[{id:"atk_up"}].stacks int 1 run scoreboard players get #atk_up_stack test.temporary
