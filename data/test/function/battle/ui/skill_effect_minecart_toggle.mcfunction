#> test:battle/ui/skill_effect_minecart_toggle
# @s = 効果アイコンを取ったプレイヤー(トロッコ式)。@macro index: 取られたスロット番号
# クラフター方式: アイコンは消費しない。選択を循環させ、拾ったアイコンを手元から消してから
# カートへ選択状態を反映して詰め直す

$data modify storage test: registry_work.slot_pick set from entity @n[tag=battle_marker,distance=..64] data.turn.effect_slot[$(index)]

function test:battle/ui/skill_effect_minecart_toggle_apply with storage test: registry_work

function test:battle/ui/skill_effect_minecart_populate
