#> test:gather/interact
# @s = interaction を右クリックしたプレイヤー(進捗 test:trigger/gather から)。近くの採取ポイントのうち、
# interaction のデータ(押した人のUUID)が自分のものを探して採る(test:gather/take)。
# 処理したポイントの interaction のデータは消して、同じ押し下げを2回処理しないようにする

advancement revoke @s only test:trigger/gather
data modify storage test: gather_work.uuid set from entity @s UUID
execute as @e[type=interaction,tag=gather_point,distance=..8] if data entity @s interaction run function test:gather/match
execute if entity @e[type=interaction,tag=gather_target,limit=1] run function test:gather/take
tag @e[type=interaction,tag=gather_target] remove gather_target
