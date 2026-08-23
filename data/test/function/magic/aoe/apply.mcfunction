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

tag @e remove hit
