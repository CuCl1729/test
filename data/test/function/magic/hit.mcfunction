#> test:magic/hit
# @s = 魔法が当たった対象。全ての魔法ダメージ(投射の命中・着弾範囲・自分中心の範囲)がここを通る
# 詠唱者は一時タグdamage_attackerで参照する(投射は着弾が詠唱の数tick後になるため、
# projectile/moveがtest.ownerから詠唱者を引いてタグを付けている)
#
# storage test: action_hit に武器の記録があれば武器弾(手替え前の毒武器などを再現する通常攻撃扱い)。
# その場合は通常攻撃と同じくbattle_member/battle_markerには当てず(先制攻撃のみ通す)、
# 既に用意済みの会心率をそのまま使い、武器の命中時バフ(hit_buff)を1回だけ掛ける。
# 武器の記録がなければ純粋な魔法(会心は出ない仕様。剣・職業スキルだけ会心がある)

execute if data storage test: action_hit{kind:"weapon"} if entity @s[tag=battle_member] run return 0
execute if data storage test: action_hit{kind:"weapon"} if entity @s[tag=battle_marker] run return 0
execute unless data storage test: action_hit{kind:"weapon"} run scoreboard players set #damage test.status.crit_rate 0

# 武器弾のみ: test:action/weapon/group が深度0で戻ったときに拾い直せるよう、
# ダメージの前に印をつけておく(純粋な魔法はここを通らない)
execute if data storage test: action_hit{kind:"weapon"} run tag @s add weapon_hit

function test:damage/

execute if data storage test: action_hit{kind:"weapon"} run function test:damage/display {verb:" の攻撃！ "}
execute unless data storage test: action_hit{kind:"weapon"} run function test:damage/display {verb:" の魔法！ "}

# 武器が「命中時に付与するバフ」を持っていれば付与する(ダメージ表示のあと、武器弾のみ)
execute if data storage test: action_hit{kind:"weapon"} run function test:attack/hit_buff

# 選んだデバフを対象へ付与する。振り分け済みの一覧は呼び出し元が用意している
# (ダメージ表示が使う#total_damage等を壊さないよう、必ず表示を出したあとに行う。武器/魔法どちらでも共通)
execute if data storage test: magic_buff.debuff[0] run data modify storage test: buff_work.pending set from storage test: magic_buff.debuff
execute if data storage test: magic_buff.debuff[0] run function test:buff/apply_list
