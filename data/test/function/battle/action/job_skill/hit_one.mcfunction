#> test:battle/action/job_skill/hit_one
# @s = ダメージを受ける対象(1体、生存している敵)。詠唱者は一時タグdamage_attackerで参照する
# (attack/hit_apply.mcfunctionと同じ表示の通し方。物理ダメージも正しく合計表示に含まれる)

function test:damage/
function test:damage/display {verb:" のスキル！ "}
