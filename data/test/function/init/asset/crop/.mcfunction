#> test:init/asset/crop/
# 普通の作物のドロップのレジストリ(スプレッドシートの「作物のドロップ」タブから生成)。asset.crop.<作物> と asset.crop_ids

data modify storage test: asset.crop set value {}
data modify storage test: asset.crop_ids set value []
function test:init/asset/crop/generated/crops

# 魔法作物: asset.magic_crop.<id> と asset.magic_crop_ids(スプレッドシートの「魔法作物」タブから生成)
data modify storage test: asset.magic_crop set value {}
data modify storage test: asset.magic_crop_ids set value []
function test:init/asset/crop/generated/magic_crops
