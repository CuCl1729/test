#> test:craft/custom/lookup
# @macro c0〜c8: 9マスの文字。つないだキーで索引を引き、あれば craft_work.match = {recipe, need} に写す

$data modify storage test: craft_work.match set from storage test: asset.recipe_index."$(c0),$(c1),$(c2),$(c3),$(c4),$(c5),$(c6),$(c7),$(c8)"
