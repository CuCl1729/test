#> test:init/asset/recipe/
# カスタムクラフターのレシピ(スプレッドシートの「レシピ」タブから生成)。asset.recipe.<id>・asset.recipe_ids・asset.recipe_index

data modify storage test: asset.recipe set value {}
data modify storage test: asset.recipe_ids set value []
data modify storage test: asset.recipe_index set value {}
function test:init/asset/recipe/generated/recipes
