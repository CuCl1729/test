#> test:factory/leave
# @s = 工場にいるプレイヤー。記録した場所(oh_my_dat の factory_return)へ、向きも元のまま戻す。
# 記録が無ければ、「定数」タブの戻る場所(test:action の factory_return_x/y/z)へ戻す

function #oh_my_dat:please
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].factory_return.dim run return run function test:factory/leave_to with storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].factory_return
function test:factory/leave_default with storage test: asset.config
