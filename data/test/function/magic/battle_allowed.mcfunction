#> test:magic/battle_allowed
# 入力: storage test: magic.player。今の asset.magic.types/effects で battle:0b が付いた要素のうち、
# どれか1つでも使われていれば0を返す(type_flags・旧形式のmagic_type・直接効果effect・付与バフbuffのどれでも)。
# 入力のmagic.playerが無ければ0を返す。既存の旧フィールドが単に無いだけでは拒否しない(今のレジストリに
# battle:0bが実在して、かつ使われているときだけ拒否する)。手番の行動と防具の自動発動の両方で使う。
# 組み合わせの妥当性(段の構造)は見ない。既存のレシピ側判定(test:magic/recipe/battle_allowed)とは別物

execute unless data storage test: magic.player run return 0

scoreboard players set #battle_magic_ok test.temporary 1

data modify storage test: battle_magic_check.types_queue set from storage test: asset.magic.types
function test:magic/battle_allowed_type_loop

data modify storage test: battle_magic_check.effects_queue set from storage test: asset.magic.effects
function test:magic/battle_allowed_effect_loop

return run scoreboard players get #battle_magic_ok test.temporary
