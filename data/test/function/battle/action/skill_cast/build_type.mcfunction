#> test:battle/action/skill_cast/build_type
# @macro id: タイプid。選択中ならクラフト時と同じアセット関数で魔法へ組み込む

$execute unless data storage test: registry_work.combo.type_flags{$(id):1b} run return 0

$function test:asset/magic/type/$(id)
