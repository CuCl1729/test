#> test:equip/proc/hp_low_check
# @s = hp_lowの枠に中身(魔法・アイテム)がある人(test.equip.has_hp_low=1。test:tickから、at @s)。
# HPが最大HPの asset.equip.hp_low_percent % を「下回った瞬間」に1回だけ hp_low を予約する。
# 下回っている間はタグ equip_hp_low を持ち、しきい値以上に戻ったら外す(また発動できるようになる)。
# HPはダメージ以外(毒など)でも減るので、ダメージ処理の中ではなくtickで毎回比べる。
# ターン制のアリーナでは発動しない(タグは付けるので、アリーナを出てもすぐには発動しない)

scoreboard players operation #hp_now test.temporary = @s test.status.hp
scoreboard players operation #hp_now test.temporary *= #100 test.constant
execute store result score #hp_line test.temporary run data get storage test: asset.equip.hp_low_percent
scoreboard players operation #hp_line test.temporary *= @s test.status.hp_max

execute if score #hp_now test.temporary >= #hp_line test.temporary run return run tag @s remove equip_hp_low
execute if entity @s[tag=equip_hp_low] run return 0

tag @s add equip_hp_low
execute if dimension test:arena run return 0
execute unless score @s test.status.hp matches 1.. run return 0
function test:debug/log {msg:"防具の自動発動: HPがしきい値を下回った(hp_low)"}
function test:equip/proc/queue {event:"hp_low"}
