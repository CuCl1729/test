#> test:magic/crafter/validate_type
# @macro id: 検査するタイプid
# このタイプが使われていなければ何もしない。使われていれば、conflictsに載っているタイプも
# 一緒に使われていないかを1件ずつ調べる

$execute unless data storage test: registry_work.combo.type_flags{$(id):1b} run return 0

$data modify storage test: registry_work.conflict_queue set from storage test: asset.magic.types[{id:"$(id)"}].conflicts
function test:magic/crafter/validate_conflict_loop
