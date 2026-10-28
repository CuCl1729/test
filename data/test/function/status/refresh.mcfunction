#> test:status/refresh
# @s = 計算する人。@macro status: ステータス名。test:status/update と同じだが、次のときは計算し直さない
# - プレイヤー以外(装備が無いので、召喚時の値をそのまま使う)
# - ターン制のアイテム式UI(battle_ui=2)の戦闘中。メインハンドが行動アイテムに入れ替わっていて武器の補正が
#   消えるので、行動アイテムを配る前に test:battle/ui/item で計算した値を使う

execute unless entity @s[type=player] run return 0
execute if score @s test.battle.id matches 1.. if score @s test.settings.battle_ui matches 2 run return 0
$function test:status/update {status:"$(status)"}
