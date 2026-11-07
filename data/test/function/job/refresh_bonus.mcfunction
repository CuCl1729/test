#> test:job/refresh_bonus
# @s = プレイヤー。職業のボーナス(レベルの成長と取得済みのパッシブ)とプレイヤーレベルの共通成長をゼロから組み直し、実効ステータスへ反映する。
# 何度呼んでも同じ値になる。HPは最大値を超えた分を切り詰めるだけで回復はしない。ターン制の戦闘中に行動UIを
# 持っているときは組み直さない(手番の始めの test:battle/turn_start_player で組み直される)

function #oh_my_dat:please
function test:job/recalc_bonus
function test:status/level_bonus
execute unless function test:status/ui_in_hand run function test:equip/rebuild_status
