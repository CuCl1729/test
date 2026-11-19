#> test:magic/beam/root/register
# @s = 詠唱者(ビームの持ち主)。combo/behavior/beam から、endpoint_aoe等を決めた後・test.beamを保存する前に呼ぶ。
# リンク無しの単発ビームでも、毎tickのダメージ適用先次元を覚えるため beam_dimension は必ず刻む
data modify storage test: magic.player.beam_dimension set from entity @s Dimension

scoreboard players set #beam_root_incoming test.temporary 0
execute if data storage test: magic.player.root store result score #beam_root_incoming test.temporary run data get storage test: magic.player.root.id

execute unless score @s test.magic.beam_root matches -2147483648..2147483647 run scoreboard players set @s test.magic.beam_root 0
scoreboard players operation #beam_root_old test.temporary = @s test.magic.beam_root

# 前に持っていたルートが今回と違うときだけ、そのぶんの仮想の保持を外す(同じIDなら触らない: 重複発動を安定させるため)
execute if score #beam_root_old test.temporary matches 1.. unless score #beam_root_old test.temporary = #beam_root_incoming test.temporary run function test:magic/beam/root/stop

scoreboard players operation @s test.magic.beam_root = #beam_root_incoming test.temporary
execute if score #beam_root_incoming test.temporary matches 0 run return 1

execute unless data storage test: magic.player.root run return 0
execute store result score #beam_root_ok test.temporary run function test:magic/root/hold with storage test: magic.player.root
execute unless score #beam_root_ok test.temporary matches 1 run return 0

data modify storage test: beam_root_work set value {}
execute store result storage test: beam_root_work.owner int 1 run scoreboard players get @s OhMyDatID
execute store result storage test: beam_root_work.root int 1 run scoreboard players get #beam_root_incoming test.temporary
data modify storage test: beam_root_work.dimension set from storage test: magic.player.beam_dimension
function test:magic/beam/root/register_entry with storage test: beam_root_work
return 1
