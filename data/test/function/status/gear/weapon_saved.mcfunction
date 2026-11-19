#> test:status/gear/weapon_saved
# @s = ターン制の戦闘中のプレイヤー。メインハンドが行動UIのアイテムに差し替わっていて、かつ装備の
# キャッシュがまだ無いときに使う。手番の始め(test:battle/open_player_turn)にこのアリーナの目印へ
# 控えた「差し替え前の本物の武器」の custom_data を装備計算の入口へ写す。
# 空の武器で当て推量をしないため、同じ戦闘idの目印だけを見る(近くの別アリーナの目印は使わない)。
# 控えが見つかったら 1、目印ごと無い・手番の控えが無いなら 0 を返す(呼び出し側が計算をやめる)。
# actor_weapon はあるのに item が無いのは「特別な補正の無い本物の武器」なので {} のまま 1

data remove storage test: status_gear.saved
$execute as @e[tag=battle_marker,scores={test.battle.id=$(battle)},limit=1] run data modify storage test: status_gear.saved set from entity @s data.turn.actor_weapon

data modify storage test: status_gear.weapon set value {}
execute if data storage test: status_gear.saved.item run data modify storage test: status_gear.weapon set from storage test: status_gear.saved.item

execute store success score #gear_snap test.buff.work if data storage test: status_gear.saved
data remove storage test: status_gear.saved
return run scoreboard players get #gear_snap test.buff.work
