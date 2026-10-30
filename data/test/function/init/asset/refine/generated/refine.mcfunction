# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:init/asset/refine/generated/refine
# 機械で原石を加工した結果(スプレッドシートの「精錬の主産物」「精錬の副産物」「前処理の副産物」タブ)。
#   asset.refine.<原石> = {main:[{material, weight, weight_rare, count, count_stage}], by:[{material, chance, chance_rare, chance_stage, count}]}
#     main は精錬炉で必ず1つ重みで選ぶ(重み = weight + weight_rare × (レア度−1)、個数 = count + count_stage × 段階)。
#     by は行ごとに確率(%) = chance + chance_rare × (レア度−1) + chance_stage × 段階 で出る
#   asset.pre_by.<前処理の機械>.<原石> = [{material, chance, chance_rare, count}]: 前処理の副産物(確率 = chance + chance_rare × (レア度−1))

data modify storage test: asset.refine.copper set value {main:[{material:"copper_ingot",weight:90,weight_rare:0,count:1,count_stage:1},{material:"pure_copper",weight:10,weight_rare:20,count:1,count_stage:0}],by:[{material:"slag",chance:20,chance_rare:5,chance_stage:20,count:1}]}
data modify storage test: asset.refine.iron set value {main:[{material:"iron_ingot",weight:90,weight_rare:0,count:1,count_stage:1},{material:"steel",weight:10,weight_rare:20,count:1,count_stage:0}],by:[{material:"slag",chance:20,chance_rare:5,chance_stage:20,count:1}]}
data modify storage test: asset.pre_by.crusher.copper set value [{material:"stone_dust",chance:30,chance_rare:5,count:1}]
data modify storage test: asset.pre_by.crusher.iron set value [{material:"stone_dust",chance:30,chance_rare:5,count:1}]
