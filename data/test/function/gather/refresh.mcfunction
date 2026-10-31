#> test:gather/refresh
# @s = 採取ポイント(interaction)。@macro point/type/dim: ポイント・採取物・マップ。
# 復活の時刻(gather_state.<マップ>.<ポイント>.ready_at、ゲーム時間)を過ぎていれば元の見た目に、まだなら採った後の見た目にする
# (tag=gather_used で、変わるときだけ書き換える)。状態はエンティティではなくストレージに持つので、置き直しても消えない

scoreboard players set #gather_ready test.temporary 0
$execute store result score #gather_ready test.temporary run data get storage test: gather_state.$(dim).$(point).ready_at
$execute if score #gather_ready test.temporary <= #gather_now test.temporary if entity @s[tag=gather_used] run function test:gather/look with storage test: asset.gather.$(type)
execute if score #gather_ready test.temporary <= #gather_now test.temporary run return run tag @s remove gather_used
$execute unless entity @s[tag=gather_used] run function test:gather/look_after with storage test: asset.gather.$(type)
tag @s add gather_used
