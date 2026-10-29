#> test:reward/field_kill
# @s = ターン制の戦闘の外で倒された敵(test:tickから、このtickの終わりに消される直前に、at @s)。
# 32ブロック以内のプレイヤー全員に報酬(経験値・ドロップ・装備のドロップ・職業の経験値)を渡す(test:battle/grant_reward)。
# ダメージの途中では渡さない(個別ストレージの参照先が切り替わるなど、ダメージ処理の作業用データを壊さないため)

tag @a[distance=..32] add battle_reward_recipient
function test:battle/grant_reward
tag @a remove battle_reward_recipient
