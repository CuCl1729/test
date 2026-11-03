#> test:magic/place/touch
# @s = 設置物(at @s)。@macro radius: 起動する距離(ほかのキーも渡ってくるが使わない)。
# 持ち主以外のプレイヤー(tag=!device_owner)か、戦闘に入っていない敵が radius 以内に来たら起動する
$execute if entity @a[distance=..$(radius),gamemode=!spectator,tag=!device_owner] run return run function test:magic/place/fire
$execute if entity @e[tag=enemy,tag=!battle_member,distance=..$(radius)] run return run function test:magic/place/fire
