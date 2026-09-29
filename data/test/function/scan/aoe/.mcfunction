#> test:scan/aoe/
# @s = 攻撃者(プレイヤー)。目の位置を要に、視線方向を中心とした半角#aoe_half_angle・半径#aoe_reachの扇を
# 半径1, 2, …, reachの同心円の弧に分け、弧の上にほぼ1ブロック間隔で置いたサンプル点で
# ヒットボックスの接触判定(scan/aoe/probe)を行う。弧ごとに角度の刻みを変えるので、射程を伸ばしても隙間ができない。
# 扇の面は視線方向とプレイヤーの左右方向で張る平面なので、見上げる/見下ろすとその向きに傾く。
# サンプル点ごとにパーティクルも出すので、表示される扇と判定範囲は一致する。
# #aoe_half_angle/#aoe_reach(いずれもtest.temporary)は呼び出し元(attack/aoe、job/skill/handler/damage_cone)で設定済み

# 角度は0.1°単位で扱う(外側の弧では1°より細かい刻みが要るため)
scoreboard players operation #aoe_half_tenths test.temporary = #aoe_half_angle test.temporary
scoreboard players operation #aoe_half_tenths test.temporary *= #10 test.constant
scoreboard players set #aoe_ring test.temporary 1

# at @sで上下の角度も含めた向きを引き継ぐ(positionedで基準点は足元に戻るので、以降の^ ^ ^はずれない)
execute at @s anchored eyes positioned ^ ^ ^ run function test:scan/aoe/ring

function test:attack/damage
