#> test:factory/leave_to
# @s = プレイヤー。@macro dim/x/y/z/yaw/pitch: 工場へ行く前の場所と向き。そこへ戻す

$execute in $(dim) run tp @s $(x) $(y) $(z) $(yaw) $(pitch)
return 1
