# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:init/asset/generated/config
# 定数(スプレッドシートの「定数」タブ)。asset.config.<キー>
#   turn_time: 手番の制限時間(秒) / turn_warn: 予告を出す残り時間(秒) / enemy_delay: 敵が行動するまで(tick) / accessory_limit: 効くアクセサリーの数 / machine_fuel_max: 機械に蓄えられる燃料(回数)
#   factory_plot_size / factory_plot_spacing: 工場の区画の大きさと間隔 / factory_floor_y / factory_top_y: 区画の床と建築できる一番上 /
#   factory_return_x/y/z: 工場から戻る場所が記録されていないときの test:action の座標

data modify storage test: asset.config set value {turn_time:30,turn_warn:10,enemy_delay:20,accessory_limit:2,machine_fuel_max:64,factory_plot_size:48,factory_plot_spacing:512,factory_floor_y:63,factory_top_y:127,factory_return_x:0,factory_return_y:0,factory_return_z:0}
