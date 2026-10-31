# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:init/asset/crop/generated/magic_crops
# 魔法作物(スプレッドシートの「魔法作物」タブ)。asset.magic_crop.<id> = {name, seed_item, seed_model, block, ages, last, step, essence, min, max, seed_chance}。
# ages[段階] = 見た目の age、last = 育ちきった段階、step = 1段階の tick。植える・育てる・収穫は test:farm/

data modify storage test: asset.magic_crop.earth_crop set value {name:"土の作物",seed_item:"minecraft:recovery_compass",seed_model:"minecraft:melon_seeds",block:"minecraft:wheat",ages:[0,1,2,3,4,5,6,7],last:7,step:343,essence:"earth_essence",min:1,max:2,seed_chance:5}
data modify storage test: asset.magic_crop_ids append value "earth_crop"
data modify storage test: asset.magic_crop.water_crop set value {name:"水の作物",seed_item:"minecraft:recovery_compass",seed_model:"minecraft:pumpkin_seeds",block:"minecraft:beetroots",ages:[0,1,2,3],last:3,step:1200,essence:"water_essence",min:1,max:1,seed_chance:5}
data modify storage test: asset.magic_crop_ids append value "water_crop"
