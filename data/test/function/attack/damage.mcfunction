# 通常のリアルタイムダメージ。既にターン制バトルに参加している相手(battle_member)には当てない。
# ただし戦闘開始のきっかけになる一撃はこの時点ではまだbattle_memberではないため、先制攻撃として通る。
# @s(攻撃者、常にプレイヤー)を一時タグで参照できるようにしてから対象ごとに処理する
tag @s add damage_attacker

# ダメージを与えるのはHPを持つものだけ(範囲に入ったHP表示の文字やアイテムまで0になって消されないように)
execute as @e[tag=hit,tag=!battle_marker,tag=!battle_member,scores={test.status.hp=1..}] run function test:attack/hit_apply

tag @e remove damage_attacker

function test:action/finish