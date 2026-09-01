#> test:projectile/burst
# @s = 範囲タイプと組み合わせた投射体。その地点を中心に円状へ効果を出す
# (#damage系は呼び出し元のprojectile/moveが投射体の値から設定済み)
# 弾を消すかどうかはここでは決めない。呼び出したハンドラが#event_resultで指示する
# (「爆発するが弾は残って跳ね返る」といった挙動も書けるようにするため)

scoreboard players operation #aoe_radius test.temporary = @s test.aoe_radius

# 投射体が運んできたバフ一覧を振り分けておく(配布はmagic/aoe/applyとmagic/hitが行う)
function test:projectile/prepare_buff

# 投射タイプは攻撃系の効果しか組み合わせられないため、着弾では回復を行わない
scoreboard players set #aoe_heal test.temporary 0

execute at @s run function test:magic/aoe/scan
execute at @s run function test:magic/aoe/apply
