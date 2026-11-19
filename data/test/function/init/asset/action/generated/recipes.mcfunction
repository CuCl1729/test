# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:init/asset/action/generated/recipes
# 信頼済みの組み立て列(スプレッドシートの「魔法構成」タブ)。魔法台を介さずコード側(武器の核など)が使う
# magic_recipe。asset.action.recipes.<id> = {build:[要素id…], settings:[{stage:{<上書き>}, cost?, link?:{params, cost?}}…]}
# build は段ごとの要素(重ねがけ含む)とつなぎを順に並べたもの。settings は段の順(つなぎは直前の段のsettingsに入る)

data modify storage test: asset.action.recipes set value {}
data modify storage test: asset.action.recipes.core_cone set value {build:["aoe"],settings:[]}
data modify storage test: asset.action.recipes.core_cone.settings append value {stage:{}}
data modify storage test: asset.action.recipes.core_cone.settings[-1].stage.aoe.shape set value "cone"
data modify storage test: asset.action.recipes.core_cone.settings[-1].stage.aoe.half_angle set value 45
data modify storage test: asset.action.recipes.core_cone.settings[-1].cost set value 20
