# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:init/asset/magic/generated/combos
# 要素の組み合わせの表(スプレッドシートの「組み合わせ」タブ)。asset.magic.combos に1行ずつ足す。
# クラフトの検証・魔法台の説明・実行時のディスパッチはすべて test:magic/combo/match でこの表を読む。
#   require をすべて含み forbid を1つも含まない行が当たる(ほかの要素が増えても無効にならない)。
#   当たる行が無い組み合わせは成立しない(魔法台は desc を使って理由を出す)

data modify storage test: asset.magic.combos set value []
data modify storage test: asset.magic.combos append value {id:"shot",apply:"stage",require:["projectile"],forbid:["continuous","self","place"],emitter:"player",behavior:"shot",pay:"upfront",params:{},desc:"投射"}
data modify storage test: asset.magic.combos append value {id:"radial",apply:"stage",require:["projectile"],forbid:["continuous","homing","self","place"],emitter:"source",behavior:"radial",pay:"upfront",params:{},desc:"放射"}
data modify storage test: asset.magic.combos append value {id:"aimed",apply:"stage",require:["projectile","homing"],forbid:["continuous","self","place"],emitter:"source",behavior:"aimed",pay:"upfront",params:{},desc:"追尾"}
data modify storage test: asset.magic.combos append value {id:"nova",apply:"stage",require:["aoe"],forbid:["continuous","homing","projectile","self","place"],emitter:"any",behavior:"nova",pay:"upfront",params:{},desc:"範囲"}
data modify storage test: asset.magic.combos append value {id:"self_cast",apply:"stage",require:["self"],forbid:["continuous","homing","projectile","aoe","place"],emitter:"any",behavior:"self",pay:"upfront",params:{},desc:"自己"}
data modify storage test: asset.magic.combos append value {id:"device",apply:"stage",require:["place"],forbid:["continuous","homing","projectile","self","aoe"],emitter:"player",behavior:"device",pay:"upfront",params:{},desc:"設置"}
data modify storage test: asset.magic.combos append value {id:"device_at",apply:"stage",require:["place"],forbid:["continuous","homing","projectile","self","aoe"],emitter:"source",behavior:"device_at",pay:"upfront",params:{},desc:"設置"}
data modify storage test: asset.magic.combos append value {id:"beam",apply:"stage",require:["continuous","projectile"],forbid:["homing","aoe","self","place"],emitter:"player",behavior:"beam",pay:"upkeep",params:{endpoint_aoe:0},desc:"ビーム(押している間)"}
data modify storage test: asset.magic.combos append value {id:"beam_aoe",apply:"stage",require:["continuous","projectile","aoe"],forbid:["homing","self","place"],emitter:"player",behavior:"beam",pay:"upkeep",params:{endpoint_aoe:1},desc:"ビーム(押している間・行き止まりで範囲)"}
data modify storage test: asset.magic.combos append value {id:"beam_auto",apply:"stage",require:["continuous","projectile"],forbid:["aoe","self","place"],emitter:"source",behavior:"beam_auto",pay:"upfront",params:{endpoint_aoe:0},desc:"自動ビーム"}
data modify storage test: asset.magic.combos append value {id:"beam_auto_aoe",apply:"stage",require:["continuous","projectile","aoe"],forbid:["self","place"],emitter:"source",behavior:"beam_auto",pay:"upfront",params:{endpoint_aoe:1},desc:"自動ビーム(行き止まりで範囲)"}
data modify storage test: asset.magic.combos append value {id:"field",apply:"stage",require:["continuous","aoe"],forbid:["homing","projectile","self","place"],emitter:"any",behavior:"field",pay:"upfront",params:{},desc:"継続する場"}
data modify storage test: asset.magic.combos append value {id:"self_sustain",apply:"stage",require:["continuous","self"],forbid:["homing","projectile","aoe","place"],emitter:"any",behavior:"self_sustain",pay:"upfront",params:{},desc:"自己持続"}
data modify storage test: asset.magic.combos append value {id:"periodic_device",apply:"link",require:["periodic","place"],forbid:["projectile","self"],emitter:"any",behavior:"emit",pay:"upfront",params:{},desc:"設置物から一定間隔"}
data modify storage test: asset.magic.combos append value {id:"periodic_projectile",apply:"link",require:["periodic","projectile"],forbid:["place","self"],emitter:"any",behavior:"emit",pay:"upfront",params:{},desc:"飛んでいる弾から一定間隔"}
data modify storage test: asset.magic.combos append value {id:"periodic_self",apply:"link",require:["periodic","self"],forbid:["place","projectile"],emitter:"any",behavior:"emit",pay:"upfront",params:{},desc:"自分から一定間隔"}
