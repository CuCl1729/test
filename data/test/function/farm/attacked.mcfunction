#> test:farm/attacked
# @s = 何かを攻撃したプレイヤー(進捗 test:trigger/crop_hit から。interaction を左クリックすると player_hurt_entity が発火する)。
# 近くの魔法作物のうち、attack のデータ(攻撃した人のUUID)が自分のものを抜く(種を1個落として消える)

advancement revoke @s only test:trigger/crop_hit
data modify storage test: gather_work.uuid set from entity @s UUID
execute as @e[type=interaction,tag=magic_crop,distance=..8] if data entity @s attack run function test:farm/attack_match
