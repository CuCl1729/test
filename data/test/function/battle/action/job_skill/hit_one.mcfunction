#> test:battle/action/job_skill/hit_one
# @s = ダメージを受ける対象(1体、生存している敵)。詠唱者は一時タグ damage_attacker と battle_attacker で参照する
# (attack/hit_apply.mcfunctionと同じ表示の通し方。物理ダメージも正しく合計表示に含まれる)。
# 当たった後は通常攻撃と同じく、武器の「命中時に付与するバフ」と防具の attack_hit を起こす

function test:damage/
function test:damage/display {verb:" のスキル！ "}
function test:battle/action/attack_hit_buff
