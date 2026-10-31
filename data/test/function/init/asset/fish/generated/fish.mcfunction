# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:init/asset/fish/generated/fish
# 釣り(スプレッドシートの「釣り場」「釣りの中身」タブ)。asset.fish_pool.<id> = {entries:[{material, weight, min, max}], total}。
# asset.fishing_spots は釣り場の行(上ほど優先。デバッグの表示用。釣れる目印はルートテーブル gameplay/fishing が決める)

data modify storage test: asset.fish_pool.default set value {entries:[{material:"small_fish",weight:80,min:1,max:1},{material:"big_fish",weight:20,min:1,max:1}],total:100}
data modify storage test: asset.fish_pool_ids append value "default"
data modify storage test: asset.fish_pool.pond set value {entries:[{material:"small_fish",weight:40,min:1,max:2},{material:"big_fish",weight:60,min:1,max:1}],total:100}
data modify storage test: asset.fish_pool_ids append value "pond"
data modify storage test: asset.fish_pool.pond_night set value {entries:[{material:"night_fish",weight:100,min:1,max:1}],total:100}
data modify storage test: asset.fish_pool_ids append value "pond_night"
data modify storage test: asset.fish_token_item set value {item:"minecraft:recovery_compass",model:"minecraft:cod",name:"釣った魚"}
data modify storage test: asset.fishing_spots append value {id:"pond_night",pool:"pond_night",weather:"any",time:"night",x1:-50,y1:-64,z1:-50,dx:100,dy:74,dz:100}
data modify storage test: asset.fishing_spots append value {id:"pond",pool:"pond",weather:"any",time:"any",x1:-50,y1:-64,z1:-50,dx:100,dy:74,dz:100}
