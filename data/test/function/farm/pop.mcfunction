#> test:farm/pop
# @s = 魔法作物。@macro id: 魔法作物のid(ほかのキーも渡ってくるが使わない)。その場に種を1個落とし、見た目ごと消える
# (左クリックで抜いたとき・下の耕地が無くなったとき)

$execute store result score #seed_built test.temporary run function test:item/magic_seed/build {id:"$(id)"}
execute if score #seed_built test.temporary matches 1 at @s run function test:item/drop_at
execute at @s align xyz run kill @e[type=block_display,tag=magic_crop_display,distance=..0.1]
kill @s
$function test:debug/log {msg:"魔法作物を抜いた: $(id)"}
return 1
