#> test:battle/ui/target_select
# @s = 対象を選ぶプレイヤー(チャット式)。敵が2体以上いる場合のみ呼ばれる想定
# (1体の場合の自動決定は呼び出し元(attack.mcfunction等)で処理済み)

scoreboard players set @s test.battle.target_select 0
scoreboard players enable @s test.battle.target_select

scoreboard players set @e[tag=battle_marker,sort=nearest,limit=1] test.battle.awaiting_target 1

function test:battle/ui/target_display
