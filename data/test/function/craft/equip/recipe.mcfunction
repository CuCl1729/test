#> test:craft/equip/recipe
# @macro equip_material: スロット9の素材の種類。素材ごとのレシピ(craft/equip/recipe/<素材>)を呼ぶ
# (型紙の部位はstorage test: loot.equip_partにあり、レシピの中のpickが読む)。
# レシピの無い素材なら関数が無いのでここで失敗し、何も作られない

$function test:craft/equip/recipe/$(equip_material)
