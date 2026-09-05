#> test:battle/enemy_ai/decide
# @s = 手番の敵。攻撃/防御/固有ギミックを重み付き抽選で選び、対応する行動を実行する。
# enemy.data.ai(asset/enemy/<name>/.mcfunctionが宣言する。宣言が無くても攻撃と最低限の防御だけの
# シンプルな敵として動く)を読んで候補と重みを組み立てる

scoreboard players set #hp_percent test.buff.work 100
scoreboard players set #hp_cur test.buff.work 0
scoreboard players set #hp_max test.buff.work 1
scoreboard players operation #hp_cur test.buff.work = @s test.status.hp
scoreboard players operation #hp_max test.buff.work = @s test.status.hp_max
execute if score #hp_max test.buff.work matches 1.. run scoreboard players operation #hp_percent test.buff.work = #hp_cur test.buff.work
execute if score #hp_max test.buff.work matches 1.. run scoreboard players operation #hp_percent test.buff.work *= #100 test.constant
execute if score #hp_max test.buff.work matches 1.. run scoreboard players operation #hp_percent test.buff.work /= #hp_max test.buff.work

# 攻撃の重みは固定。防御はHPが減っても増えない固定値(戦闘が長引くのを防ぐため、敵は基本的に
# 防御を選ばない。宣言が無ければ既定値0=一切防御しない。特定の敵にだけ防御行動を持たせたい場合は
# data.ai.defend_weightで明示的に重みを宣言する)
scoreboard players set #attack_weight test.buff.work 60

scoreboard players set #defend_weight test.buff.work 0
execute store result score #defend_weight test.buff.work run data get entity @s data.ai.defend_weight
execute if score #defend_weight test.buff.work matches ..0 run scoreboard players set #defend_weight test.buff.work 0

# 固有ギミック(HP条件・クールダウンを満たすものだけ)を候補に積む
data modify storage test: enemy_ai_work.candidates set value []
data modify storage test: enemy_ai_work.gimmick_queue set value []
execute if data entity @s data.ai.gimmicks[0] run data modify storage test: enemy_ai_work.gimmick_queue set from entity @s data.ai.gimmicks
function test:battle/enemy_ai/gimmick_filter_loop

# 合計重みを求める(攻撃+防御+ギミック)
scoreboard players operation #total_weight test.buff.work = #attack_weight test.buff.work
scoreboard players operation #total_weight test.buff.work += #defend_weight test.buff.work

data modify storage test: enemy_ai_work.weight_sum_queue set from storage test: enemy_ai_work.candidates
function test:battle/enemy_ai/sum_gimmick_weights_loop

execute if score #total_weight test.buff.work matches ..0 run scoreboard players set #total_weight test.buff.work 1

# 1〜合計重みの範囲で抽選し、攻撃→防御→ギミックの順に重みぶんずつ引いていって選ばれた行動を実行する
scoreboard players set #roll test.buff.work 0
execute store result score #roll test.buff.work run random value 1..2147483647
scoreboard players operation #roll test.buff.work %= #total_weight test.buff.work
scoreboard players add #roll test.buff.work 1

execute if score #roll test.buff.work <= #attack_weight test.buff.work run return run function test:battle/action/attack
scoreboard players operation #roll test.buff.work -= #attack_weight test.buff.work

execute if score #roll test.buff.work <= #defend_weight test.buff.work run return run function test:battle/action/defend
scoreboard players operation #roll test.buff.work -= #defend_weight test.buff.work

data modify storage test: enemy_ai_work.dispatch_queue set from storage test: enemy_ai_work.candidates
function test:battle/enemy_ai/dispatch_gimmick_loop
