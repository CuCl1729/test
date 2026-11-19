#> test:magic/aoe/apply
# scanで拾った対象(hitタグ)へ、組み合わせた効果をまとめて適用する。
# 攻撃効果は敵へ、回復効果は味方(プレイヤー)へ適用する

# 旧剣AoE(武器コンテキストの明示的cone)はscan側で既に薙ぎ払いのパーティクル/音を出しているため、
# ここでの爆発演出は二重発生になる。他のcone/魔法AoEでは従来通り鳴らす
# #aoe_weapon_cone は呼び出し元(cast_body/beam/prepare/burst)がこの発動自身の内容から用意する
# (projectile/burstなどはこの関数が呼ばれるまでにstorage test: magic.playerが別の詠唱で
# 上書きされている場合があり、ここで読み直すと取り違える)
execute if score #aoe_weapon_cone test.temporary matches 0 run particle explosion ~ ~0.5 ~ 0 0 0 0 1 force @a
execute if score #aoe_weapon_cone test.temporary matches 0 run playsound minecraft:entity.generic.explode master @a ~ ~ ~ 1 1.4

# ダメージ(test:magic/hitはfunction test:damage/のみの既存関数。投射魔法の着弾処理と同じ経路)
execute as @e[tag=hit,type=!player,tag=!projectile,scores={test.status.hp=1..}] run function test:magic/hit

# 回復(magic/effect/healは@sを回復する再帰関数なので、対象ごとにtest.repeatをリセットしてから呼ぶ)
# 回復するかどうかは呼び出し元が#aoe_healで指定する(投射体の着弾は詠唱から時間が経っており、
# storage test: magic.playerが別の魔法のもので上書きされている可能性があるため直接は見ない)
execute if score #aoe_heal test.temporary matches 1 as @a[tag=hit] run scoreboard players reset @s test.repeat
execute if score #aoe_heal test.temporary matches 1 as @a[tag=hit] run function test:magic/effect/heal

# 支援系のバフは範囲内の味方(プレイヤー)へ配る。攻撃系のデバフは対象ごとにmagic/hitの中で付与される。
# 振り分け済みの一覧は呼び出し元(magic/aoe/cast または projectile/burst)が用意している
execute if data storage test: magic_buff.buff[0] run data modify storage test: buff_work.pending set from storage test: magic_buff.buff
execute if data storage test: magic_buff.buff[0] as @a[tag=hit] run function test:buff/apply_list

# 蘇生(#aoe_revive は呼び出し元が指定する)。ダウン中のプレイヤーは scan で拾わない(HPが0)ので、半径で探す
execute if score #aoe_revive test.temporary matches 1 run function test:magic/aoe/revive with storage test: magic_revive

# 爆風(magic_blast は呼び出し元が用意する)。周りを中心から外へ吹き飛ばす
execute if data storage test: magic_blast.power run function test:magic/aoe/blast with storage test: magic_blast

# 旧剣AoEの移行先。action/finishはここでは呼ばない(呼ぶのは呼び出し元のtest:action/weapon/group、
# 深度0に戻った最外周でまとめて一度だけ)。battle_entranceは加入のためだけのダミーでHPを持たず、
# magic/hitのHP対象判定を通らないためweapon_hitタグが付かない。武器弾のaoeだけ、
# 下のhit掃除の前にweapon_hitへ写しておき、weapon/groupの回収に合わせる
# (HPを持つ対象はmagic/hitが既にweapon_hitを付けている)
execute if data storage test: action_hit{kind:"weapon"} run tag @e[tag=hit,tag=battle_entrance] add weapon_hit

tag @e remove hit
