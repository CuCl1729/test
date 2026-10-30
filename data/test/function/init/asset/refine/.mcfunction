#> test:init/asset/refine/
# 機械で原石を加工した結果と燃料のレジストリ(スプレッドシートの「精錬の主産物」「精錬の副産物」「前処理の副産物」「燃料」タブから生成)。
#   asset.refine.<原石> = {main, by}(精錬炉) / asset.pre_by.<前処理の機械>.<原石>(前処理の副産物) / asset.fuel."<アイテムid>" = {count}

data modify storage test: asset.refine set value {}
data modify storage test: asset.pre_by set value {}
data modify storage test: asset.fuel set value {}
function test:init/asset/refine/generated/refine
function test:init/asset/refine/generated/fuels
