#> test:battle/ui/skill_effect_minecart_toggle
# @s = 効果アイコンを取ったプレイヤー(トロッコ式)。$(effect)=効果名 $(item)=アイコンのアイテムID
# クラフター方式: アイコンは消費しない。選択をトグルし、拾ったアイコンをインベントリから消してから
# カートへ選択状態を反映して詰め直す

# 元の値を先に控えてから判定する(1行目で0にした直後に2行目が「今0かどうか」を見てしまうと
# 即座に1へ戻ってしまい、有効から無効に切り替わらなくなるため)
$scoreboard players operation #toggle_effect test.temporary = @s test.magic.select.$(effect)
$execute if score #toggle_effect test.temporary matches 1 run scoreboard players set @s test.magic.select.$(effect) 0
$execute if score #toggle_effect test.temporary matches 0 run scoreboard players set @s test.magic.select.$(effect) 1

$clear @s minecraft:$(item)[custom_data~{test:{skill_effect:"$(effect)"}}]

function test:battle/ui/skill_effect_minecart_populate
