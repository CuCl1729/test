# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:init/asset/status/generated/growth
# プレイヤーレベルによる共通の成長(スプレッドシートの「プレイヤー初期値」タブの「レベル成長」。内部の値)。
# asset.level_growth.<stat> = 1レベルごとの加算量。test:status/level_bonus が ×max(レベル−1, 0) して test.level_bonus.<stat> にする

data modify storage test: asset.level_growth set value {atk:100,def:50,hp_max:500,mp_max:200,crit_rate:0,crit_damage:0,effect_damage:0,magic_efficiency:0,divergence:0,hp_regene:0,mp_regene:0}
