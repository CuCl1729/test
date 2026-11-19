# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:init/asset/generated/config
# 定数(スプレッドシートの「定数」タブ)。asset.config.<キー>
#   turn_time: 手番の制限時間(秒) / turn_warn: 予告を出す残り時間(秒) / enemy_delay: 敵が行動するまで(tick) / accessory_limit: 効くアクセサリーの数 / machine_fuel_max: 機械に蓄えられる燃料(回数)
#   factory_plot_size / factory_plot_spacing: 工場の区画の大きさと間隔 / factory_floor_y / factory_top_y: 区画の床と建築できる一番上 /
#   factory_return_x/y/z: 工場から戻る場所が記録されていないときの test:action の座標 /
#   magic_fan_angle: 複数発射が広がる扇の角度(度。全体の幅) / magic_root_limit: キャスト1回につき子ステージが合計で使える発動回数の上限 /
#   magic_root_max_alive: 発動ルートの子ステージが同時に存在できる持続物の数の上限(一定間隔・ビームの着弾など、繰り返す魔法すべてで共通)

data modify storage test: asset.config set value {turn_time:30,turn_warn:10,enemy_delay:20,accessory_limit:2,machine_fuel_max:64,factory_plot_size:48,factory_plot_spacing:512,factory_floor_y:63,factory_top_y:127,factory_return_x:0,factory_return_y:0,factory_return_z:0,magic_fan_angle:120,magic_root_limit:256,magic_root_max_alive:3}
