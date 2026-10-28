#> test:equip/proc/watch_below
# @s = プレイヤー(at @s)。@macro id: イベント / stat・max: 見張るスコア test.status.<stat> と最大値 test.status.<max> /
# percent: しきい値(最大値の何%)。stat×100 が max×percent を「下回った瞬間」に1回だけ id のイベントを予約する。
# 下回っている間はタグ equip_below.<id> を持ち、しきい値以上に戻ったら外す(また発動できるようになる)。
# ターン制のアリーナでは発動しない(タグは付けるので、アリーナを出てもすぐには発動しない)

$scoreboard players operation #watch_now test.temporary = @s test.status.$(stat)
scoreboard players operation #watch_now test.temporary *= #100 test.constant
$scoreboard players set #watch_line test.temporary $(percent)
$scoreboard players operation #watch_line test.temporary *= @s test.status.$(max)

$execute if score #watch_now test.temporary >= #watch_line test.temporary run return run tag @s remove equip_below.$(id)
$execute if entity @s[tag=equip_below.$(id)] run return 0

$tag @s add equip_below.$(id)
execute if dimension test:arena run return 0
execute unless score @s test.status.hp matches 1.. run return 0
$function test:debug/log {msg:"防具の自動発動: しきい値を下回った($(id))"}
$function test:equip/proc/queue {event:"$(id)"}
