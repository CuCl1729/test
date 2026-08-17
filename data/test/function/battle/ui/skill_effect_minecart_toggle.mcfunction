#> test:battle/ui/skill_effect_minecart_toggle
# @s = 効果アイコンを取ったプレイヤー(トロッコ式)。$(effect)=効果名 $(item)=アイコンのアイテムID
# $(max)=循環させる段階数(通常の効果は2で0↔1、威力上昇は4で0〜3を循環)
# クラフター方式: アイコンは消費しない。選択を循環させ、拾ったアイコンをインベントリから消してから
# カートへ選択状態を反映して詰め直す

$scoreboard players add @s test.magic.select.$(effect) 1
$scoreboard players set #toggle_max test.temporary $(max)
$scoreboard players operation @s test.magic.select.$(effect) %= #toggle_max test.temporary

$clear @s minecraft:$(item)[custom_data~{test:{skill_effect:"$(effect)"}}]

function test:battle/ui/skill_effect_minecart_populate
