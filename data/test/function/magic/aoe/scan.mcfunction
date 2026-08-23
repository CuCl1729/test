#> test:magic/aoe/scan
# 実行位置を中心に円盤状へサンプル点を敷き、各点でヒットボックス判定(magic/aoe/probe)を行う。
# 当たったものにはhitタグが付くので、後段のmagic/aoe/applyでまとめて効果を適用する。
# 半径は #aoe_radius test.temporary で渡す
#
# 点の配置は共通処理のtest:scan/circle/に任せる。scan/circle/はAxisマーカーの回転を組み合わせて
# 実行を分岐させるため、1回の呼び出しで円周上の多数の位置にCommandが走る

data modify storage test: circle.Command set value "function test:magic/aoe/probe"
data modify storage test: circle.Yaw set value 0.0f
data modify storage test: circle.Pitch set value 0.0f

# 中心(半径0)は円周に含まれないので1回だけ判定する
function test:magic/aoe/probe

scoreboard players operation #aoe_ring test.temporary = #aoe_radius test.temporary
function test:magic/aoe/ring_loop
