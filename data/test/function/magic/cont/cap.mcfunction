#> test:magic/cont/cap
# @s = 持ち主。これから出す持続物が、発動ルート(magic.player.root)の同時生存数上限に達しているかを調べる。
# 出力: #cont_over test.temporary  1 = もう出せない
# 持続物(自動ビーム・場・自己持続)はすべて発動ルートのaliveを共有して数える(test:magic/root/can_spawn)
scoreboard players set #cont_over test.temporary 0
execute unless function test:magic/root/can_spawn run scoreboard players set #cont_over test.temporary 1
