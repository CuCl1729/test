#> test:magic/crafter/validate_conflict
# @macro conflict_id: 相反するタイプid。これも同時に使われていたら組み合わせを不正にする

$execute if data storage test: registry_work.combo.type_flags{$(conflict_id):1b} run scoreboard players set #combo_invalid test.temporary 1
