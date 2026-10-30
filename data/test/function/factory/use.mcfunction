#> test:factory/use
# @s = プレイヤー。工場の鍵の動き(デバッグメニューの[区画へ / 戻る]も同じ)。
# 工場の中なら元の場所へ戻り(test:factory/leave)、それ以外なら自分の区画へ行く(test:factory/enter)。
# 戦闘中・ダウン中・ターン制のアリーナでは使えない

execute if score @s test.battle.id matches 1.. run return run tellraw @s {text:"戦闘中は使えない",color:"gray"}
execute if entity @s[tag=downed] run return run tellraw @s {text:"倒れている間は使えない",color:"gray"}
execute at @s if dimension test:arena run return run tellraw @s {text:"ここでは使えない",color:"gray"}
execute at @s if dimension test:factory run return run function test:factory/leave
function test:factory/enter
