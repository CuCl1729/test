#> test:battle/ui/skill_effect_visible_requires
# @macro requires_type: この効果が前提とするタイプid。選択中なら表示可にする

$execute if data storage test: registry_work.combo.type_flags{$(requires_type):1b} run scoreboard players set #effect_visible test.temporary 1
