# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:init/asset/action/generated/materials
# 特殊素材の効果(スプレッドシートの「特殊素材効果」タブ)。asset.action.materials = [{id, trigger:"right_click", recipe, multiplier_min, multiplier_max} | {id, trigger:"on_hit", buff:{id, stacks, chance}}, …]。
# 毎回まるごと組み直す(reset)。既存の鍛冶・戦闘コードは次の単位まで aoe_core / poison_fang をコードに直書きしたまま使う

data modify storage test: asset.action.materials set value []
data modify storage test: asset.action.materials append value {id:"aoe_core",trigger:"right_click",recipe:"core_cone",multiplier_min:50,multiplier_max:150}
data modify storage test: asset.action.materials append value {id:"poison_fang",trigger:"on_hit",buff:{id:"poison",stacks:1,chance:30}}
