#> test:magic/root/source_self
# @s = これから子を出す発生源(弾・設置物・自動ビーム)。この個体ぶんの発生源ID(data.magic_source)を、
# まだ持っていなければ元帳から1つ取って持たせる(撃つたびに新しく作らない)。出力 = #root_self_source test.temporary
scoreboard players set #root_self_source test.temporary 0
execute unless data entity @s data.magic_root run return 0
execute unless data entity @s data.magic_source run data modify storage test: root_work.alloc set from entity @s data.magic_root
execute unless data entity @s data.magic_source run function test:magic/root/source_new with storage test: root_work.alloc
execute unless data entity @s data.magic_source run data modify entity @s data.magic_source set from storage test: root_work.source_out
execute store result score #root_self_source test.temporary run data get entity @s data.magic_source
return 1
