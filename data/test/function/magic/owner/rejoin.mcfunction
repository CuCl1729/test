#> test:magic/owner/rejoin
# @s = test.leave_game中だったプレイヤー。戻ってきた瞬間に呼ぶ。
# 本来は毎tickの owner/find がログアウトを検知してすぐ片付けるが、
# ワールドが即停止して1tickも進まずに再ログインした場合はその検知が一度も走らない。
# ここで、離れていた間ずっと残っていたこのプレイヤーの持ち分だけをまとめて片付ける。
# 設置物(magic_device)と、周期性のない普通の弾はこの片付けの対象外(そのまま残す)
function #oh_my_dat:please
function test:magic/beam/stop

scoreboard players operation #rejoin_magic_owner test.temporary = @s OhMyDatID

execute as @e[type=armor_stand,tag=magic_field] if score @s test.owner = #rejoin_magic_owner test.temporary at @s run function test:magic/field/end
execute as @e[type=armor_stand,tag=magic_beam] if score @s test.owner = #rejoin_magic_owner test.temporary at @s run function test:magic/beam/owner_gone
execute as @e[type=armor_stand,tag=magic_sustain] if score @s test.owner = #rejoin_magic_owner test.temporary at @s run function test:magic/cont/self_end
execute as @e[type=armor_stand,tag=magic_emitter] if score @s test.owner = #rejoin_magic_owner test.temporary at @s run function test:magic/periodic/emitter_end
execute as @e[tag=projectile,tag=periodic] if score @s test.owner = #rejoin_magic_owner test.temporary at @s run function test:projectile/kill
execute as @e[type=mannequin,tag=magic_dash_proxy] if score @s test.owner = #rejoin_magic_owner test.temporary at @s run function test:magic/dash/discard
