#> test:projectile/burst
# @s = 範囲タイプと組み合わせた投射体。着弾地点を中心に円状へ効果を出してから消える
# (#damage系は呼び出し元のprojectile/moveが投射体の値から設定済み)

scoreboard players operation #aoe_radius test.temporary = @s test.aoe_radius

# 投射タイプは攻撃系の効果しか組み合わせられないため、着弾では回復を行わない
scoreboard players set #aoe_heal test.temporary 0

execute at @s run function test:magic/aoe/scan
execute at @s run function test:magic/aoe/apply

function test:projectile/kill
