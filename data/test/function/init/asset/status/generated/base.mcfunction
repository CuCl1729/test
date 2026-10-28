# 自動生成: tools/datasheet/generate.ps1。直接編集しない(スプレッドシートを直して再生成する)
#> test:init/asset/status/generated/base
# @s = プレイヤー。初期の能力値(スプレッドシートの「プレイヤー初期値」タブ。内部の値)。
# test:init/asset/status/vanilla(初めて入ったとき)と test:init/(/reload のとき今いるプレイヤー全員)が呼ぶ

scoreboard players set @s test.status.base.atk 500
scoreboard players set @s test.status.base.def 250
scoreboard players set @s test.status.base.hp_max 5000
scoreboard players set @s test.status.base.mp_max 2000
scoreboard players set @s test.status.base.crit_rate 500
scoreboard players set @s test.status.base.crit_damage 15000
scoreboard players set @s test.status.base.effect_damage 2000
scoreboard players set @s test.status.base.magic_efficiency 100
scoreboard players set @s test.status.base.divergence 100
scoreboard players set @s test.status.base.hp_regene 500
scoreboard players set @s test.status.base.mp_regene 200
