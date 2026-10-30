#> test:factory/leave_default
# @s = プレイヤー。@macro factory_return_x/y/z: 戻る場所が記録されていないときの test:action の座標(asset.config。ほかのキーも渡ってくるが使わない)

$execute in test:action run tp @s $(factory_return_x) $(factory_return_y) $(factory_return_z)
