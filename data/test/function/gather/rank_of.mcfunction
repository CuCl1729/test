#> test:gather/rank_of
# @s = プレイヤー。@macro tool: 道具の種類(ほかのキーも渡ってくるが使わない)。
# 手に持っているのがその種類の採取の道具(custom_data.test.gather_tool)なら、そのランクを #gather_rank に入れる

$execute if data entity @s SelectedItem.components."minecraft:custom_data".test.gather_tool{kind:"$(tool)"} store result score #gather_rank test.temporary run data get entity @s SelectedItem.components."minecraft:custom_data".test.gather_tool.rank
