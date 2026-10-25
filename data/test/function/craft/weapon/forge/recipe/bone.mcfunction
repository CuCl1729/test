# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:craft/weapon/forge/recipe/bone
# 素材 bone のレシピ(スプレッドシートの「鍛冶場レシピ」タブ)。スロット10の触媒(catalyst_kind)ごとに作る武器

execute if data storage test: {loot:{catalyst_kind:"none"}} run function test:asset/weapon/sword/apply {material:"wooden_sword"}
execute if data storage test: {loot:{catalyst_kind:"iron_catalyst"}} run function test:asset/weapon/sword/apply {material:"iron_sword"}
execute if data storage test: {loot:{catalyst_kind:"diamond_catalyst"}} run function test:asset/weapon/sword/apply {material:"diamond_sword"}
