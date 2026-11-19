#> test:magic/root/release
# @s = 持続物(弾・場・自己持続など)が消える直前。ルート元帳(magic_roots)からこの個体のぶんを引く。
# 所属していなければ何もしない(重複呼び出しでも安全)
execute unless data entity @s data.magic_root run return 0

data modify storage test: root_work.entity set from entity @s data.magic_root
execute unless data storage test: root_work.entity.source run data modify storage test: root_work.entity.source set value 0
data remove entity @s data.magic_root
tag @s remove magic_root_member

return run function test:magic/root/release_entry with storage test: root_work.entity
