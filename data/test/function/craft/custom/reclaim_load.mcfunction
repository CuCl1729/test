#> test:craft/custom/reclaim_load
# @macro recipe: 取られた結果のレシピ。その出るものの clear の条件と個数で、取り返す

data modify storage test: craft_work.rp set value {pred:"",count:0,name:""}
$data modify storage test: craft_work.rp.pred set from storage test: asset.recipe.$(recipe).pred
$data modify storage test: craft_work.rp.count set from storage test: asset.recipe.$(recipe).out.count
$data modify storage test: craft_work.rp.name set from storage test: asset.recipe.$(recipe).name
function test:craft/custom/reclaim with storage test: craft_work.rp
