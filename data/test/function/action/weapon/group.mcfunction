#> test:action/weapon/group
# @s = 発射元(プレイヤー、またはtest.ownerを持つプレイヤー所有のアクター)。
# 実行位置/ディメンションは呼び出し元(発射元)のものをそのまま使う(ここでは移動しない)。
# $(body) = コードの定数で指定された内部関数ID(固定。シート/セル/ユーザー入力は不可)。
#
# 1回の武器弾の着弾が引き起こす「直後の段」をすべて実行してから戦闘を開始するための
# 入れ子対応スコープ。bodyは再帰的にこの関数を呼んでよく、内側のreturn0/returnrunは
# bodyの中だけに影響し、このスコープの後始末(深度のデクリメント・最外周の回収)は必ず行われる。
#> #weapon_group_depth / #weapon_group_owner は test.temporary を使う(同期的な一時状態)

execute if score #weapon_group_depth test.temporary matches 0 run tag @e[tag=weapon_hit] remove weapon_hit
execute if score #weapon_group_depth test.temporary matches 0 run scoreboard players set #weapon_group_owner test.temporary 0
execute if score #weapon_group_depth test.temporary matches 0 if entity @s[type=player] run scoreboard players operation #weapon_group_owner test.temporary = @s OhMyDatID
execute if score #weapon_group_depth test.temporary matches 0 unless entity @s[type=player] run scoreboard players operation #weapon_group_owner test.temporary = @s test.owner

scoreboard players add #weapon_group_depth test.temporary 1
$function $(body)
scoreboard players remove #weapon_group_depth test.temporary 1

# 最外周(深度が0に戻った)でのみ回収する。内側のスコープは対象/持ち主/finish呼び出しに触れない
execute if score #weapon_group_depth test.temporary matches 0 run tag @e remove hit
execute if score #weapon_group_depth test.temporary matches 0 run tag @e[tag=weapon_hit] add hit
execute if score #weapon_group_depth test.temporary matches 0 as @a[distance=0..] if score @s OhMyDatID = #weapon_group_owner test.temporary run function test:action/finish
execute if score #weapon_group_depth test.temporary matches 0 run tag @e[tag=weapon_hit] remove weapon_hit
execute if score #weapon_group_depth test.temporary matches 0 run tag @e remove hit
