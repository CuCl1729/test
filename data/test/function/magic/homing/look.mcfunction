#> test:magic/homing/look
# @s = 狙う側(at @s)。今覚えている相手(test.homing.target)が生きていれば homing_target タグを付けて 1 を返す。
# 居なくなった・倒された・戦闘に入ったときは 0 を返すので、呼び出し元が選び直す。
# 距離では外さない(探す距離の外へ出ても、相手が生きている限り追い続ける)
tag @e remove homing_target
scoreboard players set #homing_want test.temporary 0
scoreboard players operation #homing_want test.temporary = @s test.homing.target
execute if score #homing_want test.temporary matches ..0 run return 0

# distance=0.. は「実行位置と同じ次元」の意味。別の次元へ行った相手は見失ったものとして扱い、
# 呼び出し元(test:magic/homing/tick)が改めて選び直す。
# HPが1以上で、ターン制の戦闘に入っていない敵だけを「まだ追える相手」とみなす
execute as @e[tag=enemy,tag=!battle_member,distance=0..,scores={test.status.hp=1..}] if score @s test.magic.eid = #homing_want test.temporary run tag @s add homing_target
execute if entity @e[tag=homing_target] run return 1
return 0
