# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:init/generated/stat_scores
# ステータスごとのスコア(init/scoreboard の test.status.base.<名前> の一覧から作る)。test:init/scoreboard が呼ぶ
#   test.buff.m.<名前>     バフの乗率の合計(×10000。0なら加算だけの昔どおりの挙動)
#   test.buff.flat.<名前>  純粋な固定値の行だけの合計(参照値 R。式の add も m の寄与も入らない)
#   test.status.gear.<名前> 装備だけから作る取り分のキャッシュ(職業・レベルのボーナスは入れない。test:status/gear)

scoreboard objectives add test.buff.m.atk dummy
scoreboard objectives add test.buff.flat.atk dummy
scoreboard objectives add test.status.gear.atk dummy
scoreboard objectives add test.buff.m.def dummy
scoreboard objectives add test.buff.flat.def dummy
scoreboard objectives add test.status.gear.def dummy
scoreboard objectives add test.buff.m.hp_max dummy
scoreboard objectives add test.buff.flat.hp_max dummy
scoreboard objectives add test.status.gear.hp_max dummy
scoreboard objectives add test.buff.m.crit_rate dummy
scoreboard objectives add test.buff.flat.crit_rate dummy
scoreboard objectives add test.status.gear.crit_rate dummy
scoreboard objectives add test.buff.m.crit_damage dummy
scoreboard objectives add test.buff.flat.crit_damage dummy
scoreboard objectives add test.status.gear.crit_damage dummy
scoreboard objectives add test.buff.m.effect_damage dummy
scoreboard objectives add test.buff.flat.effect_damage dummy
scoreboard objectives add test.status.gear.effect_damage dummy
scoreboard objectives add test.buff.m.magic_efficiency dummy
scoreboard objectives add test.buff.flat.magic_efficiency dummy
scoreboard objectives add test.status.gear.magic_efficiency dummy
scoreboard objectives add test.buff.m.mp_max dummy
scoreboard objectives add test.buff.flat.mp_max dummy
scoreboard objectives add test.status.gear.mp_max dummy
scoreboard objectives add test.buff.m.divergence dummy
scoreboard objectives add test.buff.flat.divergence dummy
scoreboard objectives add test.status.gear.divergence dummy
scoreboard objectives add test.buff.m.mp_regene dummy
scoreboard objectives add test.buff.flat.mp_regene dummy
scoreboard objectives add test.status.gear.mp_regene dummy
scoreboard objectives add test.buff.m.hp_regene dummy
scoreboard objectives add test.buff.flat.hp_regene dummy
scoreboard objectives add test.status.gear.hp_regene dummy

data modify storage test: asset.buff.stats set value ["atk","def","hp_max","crit_rate","crit_damage","effect_damage","magic_efficiency","mp_max","divergence","mp_regene","hp_regene"]
