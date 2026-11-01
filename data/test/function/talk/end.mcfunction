#> test:talk/end
# @s = プレイヤー。会話を終える(押されても進まないように状態を消す)

tag @s remove talking
data remove storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.talk
