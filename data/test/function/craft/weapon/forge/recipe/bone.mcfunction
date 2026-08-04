#> test:craft/weapon/forge/recipe/bone
# 骨(bone)を使ったレシピ。スロット10の触媒(catalyst_kind)でティアが変わる

execute if data storage test: {loot:{catalyst_kind:"none"}} run function test:asset/weapon/sword/apply {material:"wooden_sword"}
execute if data storage test: {loot:{catalyst_kind:"iron_catalyst"}} run function test:asset/weapon/sword/apply {material:"iron_sword"}
execute if data storage test: {loot:{catalyst_kind:"diamond_catalyst"}} run function test:asset/weapon/sword/apply {material:"diamond_sword"}
