#> test:magic/owner/find
# @s = 持ち主を覚えているもの(設置物・場・ビーム・発生源。at @s)。
# 持ち主(test.owner = 詠唱者の OhMyDatID)が「使える状態」なら、その人に magic_owner タグを付けて 1 を返す。
# 使える状態 = 同じ次元に居て / 生きていて(HPが1以上で倒れていない)/ ターン制の戦闘の外。
#
# 魔法を唱えられない状態の人は「居ない」とみなす。設置物はそのあいだ全部止まり(残す)、
# 持ち主について回るもの(場・自動ビーム・一定間隔の発生源)は終わる、という決まりのための共通判定。
# 呼んだ側は使い終わったら tag @a remove magic_owner をすること
tag @a remove magic_owner
scoreboard players operation #magic_owner test.temporary = @s test.owner

# distance=0.. は「実行位置と同じ次元」の意味(別の次元のプレイヤーは選ばれない)
execute as @a[distance=0..,tag=!downed,scores={test.status.hp=1..}] if score @s OhMyDatID = #magic_owner test.temporary run tag @s add magic_owner
execute if entity @a[tag=magic_owner,scores={test.battle.id=1..}] run tag @a remove magic_owner

execute if entity @a[tag=magic_owner] run return 1
return 0
