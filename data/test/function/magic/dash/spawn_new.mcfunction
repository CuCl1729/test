#> test:magic/dash/spawn_new
# @s = 今summonされたmannequin(呼び出し元の `execute summon mannequin run function ...` で直接束縛)。
# 水平ダッシュを運ぶだけの使い捨ての代理として初期化する。yawは常に0に固定するので、
# test:move/add_impulse_x/y/z のローカルXYZ(視点基準)がそのまま世界座標のベクトルになる。
# immovable:0bにしておかないとimpulseを受けても動かない。
data merge entity @s {Rotation:[0f,0f],NoGravity:1b,immovable:0b,Invulnerable:1b,Silent:1b,Tags:["magic_dash_proxy"]}
effect give @s minecraft:invisibility infinite 0 true
team join test.dash @s

scoreboard players operation @s test.owner = #dash_owner test.temporary
scoreboard players operation @s test.dash.birth = #dash_now test.temporary
scoreboard players set @s test.dash.ready 0
scoreboard players operation @s test.impulse.x = #dash_dx test.temporary
scoreboard players set @s test.impulse.y 0
scoreboard players operation @s test.impulse.z = #dash_dz test.temporary

item replace entity @s saddle with minecraft:test_block[equippable={slot:"saddle"},enchantments={"minecraft:vanishing_curse":1,"test:move/add_impulse_x":1,"test:move/add_impulse_y":1,"test:move/add_impulse_z":1,"test:magic/dash_ack":1}]
