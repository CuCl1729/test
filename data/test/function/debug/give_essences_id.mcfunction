#> test:debug/give_essences_id
# @macro id: 魔法作物のid。そのエッセンスの素材idを debug_work.give_arg.id に入れる

$data modify storage test: debug_work.give_arg.id set from storage test: asset.magic_crop.$(id).essence
