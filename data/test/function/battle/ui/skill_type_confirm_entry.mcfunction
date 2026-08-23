#> test:battle/ui/skill_type_confirm_entry
# @macro id/role: レジストリの1件ぶん
# 選択中のデリバリタイプを数え、そのidを詠唱時のディスパッチ先として控える。
# 修飾子タイプしか選ばれていない場合はそれ自身が届け方になる(クラフト時のmagic_typeの決まり方と同じ)
# ため、役割に関係なく選択中のidをfallbackとしても控えておく

$execute unless data storage test: registry_work.combo.type_flags{$(id):1b} run return 0

$data modify storage test: registry_work.combo.fallback set value "$(id)"

$execute if data storage test: asset.magic.types[{id:"$(id)",role:"delivery"}] run scoreboard players add #delivery_count test.temporary 1
$execute if data storage test: asset.magic.types[{id:"$(id)",role:"delivery"}] run data modify storage test: registry_work.combo.delivery set value "$(id)"
