#> test:magic/aoe/apply
# scanで拾った対象(hitタグ)へ、組み合わせた効果をまとめて適用する。
# 攻撃効果は敵へ、回復効果は味方(プレイヤー)へ適用する

particle explosion ~ ~0.5 ~ 0 0 0 0 1 force @a
playsound minecraft:entity.generic.explode master @a ~ ~ ~ 1 1.4

# ダメージ(test:magic/hitはfunction test:damage/のみの既存関数。投射魔法の着弾処理と同じ経路)
execute as @e[tag=hit,type=!player,tag=!projectile] run function test:magic/hit

# 回復(magic/effect/healは@sを回復する再帰関数なので、対象ごとにtest.repeatをリセットしてから呼ぶ)
# 回復するかどうかは呼び出し元が#aoe_healで指定する(投射体の着弾は詠唱から時間が経っており、
# storage test: magic.playerが別の魔法のもので上書きされている可能性があるため直接は見ない)
execute if score #aoe_heal test.temporary matches 1 as @a[tag=hit] run scoreboard players reset @s test.repeat
execute if score #aoe_heal test.temporary matches 1 as @a[tag=hit] run function test:magic/effect/heal

# 支援系のバフは範囲内の味方(プレイヤー)へ配る。攻撃系のデバフは対象ごとにmagic/hitの中で付与される。
# 振り分け済みの一覧は呼び出し元(magic/aoe/cast または projectile/burst)が用意している
execute if data storage test: magic_buff.buff[0] run data modify storage test: buff_work.pending set from storage test: magic_buff.buff
execute if data storage test: magic_buff.buff[0] as @a[tag=hit] run function test:buff/apply_list

tag @e remove hit
