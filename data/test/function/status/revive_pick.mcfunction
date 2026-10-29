#> test:status/revive_pick
# @s = 蘇生を使う人。@macro radius: リアルタイムで届く距離(ブロック)。起こす相手を1人選んで revive_target のタグを付け、
# 選べたら1、いなければ0を返す(使う前に呼び、0ならアイテムやMPを使わない)
# - ターン制の戦闘中: 同じ戦闘で倒れている(HP0以下)プレイヤー(距離は見ない)
# - リアルタイム: radius 以内でダウンしている、自分以外の一番近いプレイヤー

tag @a remove revive_target
execute if score @s test.battle.id matches 1.. run return run function test:status/revive_pick_battle

tag @s add revive_user
$execute at @s as @a[tag=downed,tag=!revive_user,distance=..$(radius),sort=nearest,limit=1] run tag @s add revive_target
tag @s remove revive_user
execute if entity @a[tag=revive_target] run return 1
return 0
