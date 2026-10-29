#> test:status/refresh
# @s = 計算する人。@macro status: ステータス名。test:status/update と同じだが、次のときは計算し直さない
# - プレイヤー以外(装備が無いので、召喚時の値をそのまま使う)
# - ターン制の戦闘中に、メインハンドに行動UIのアイテムを持っているとき(test:status/ui_in_hand)。武器の補正が
#   消えるので、手番の始め(test:battle/turn_start_player)に組み直した値を使う

execute unless entity @s[type=player] run return 0
execute if function test:status/ui_in_hand run return 0
$function test:status/update {status:"$(status)"}
