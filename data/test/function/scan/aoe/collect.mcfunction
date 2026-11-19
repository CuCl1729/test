#> test:scan/aoe/collect
# 呼び出し元が既に立っている位置・向きをそのまま扇の要/軸として使う共通ヘルパー。
# position/anchor/atは呼び出し元側で済ませておくこと。#aoe_half_angle/#aoe_reach(test.temporary)は設定済み前提。

# 角度は0.1°単位で扱う(外側の弧では1°より細かい刻みが要るため)
scoreboard players operation #aoe_half_tenths test.temporary = #aoe_half_angle test.temporary
scoreboard players operation #aoe_half_tenths test.temporary *= #10 test.constant
scoreboard players set #aoe_ring test.temporary 1

function test:scan/aoe/ring
