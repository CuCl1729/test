#> test:magic/combo/behavior/shot
# @s = 詠唱者。実行位置 = 撃つ所。プレイヤーが撃つ投射(今までの投射魔法そのまま)。
# 追尾のdelay_ticksは、本当にプレイヤーが直接撃ったときだけ効く(防具の自動発動はequip_proc_castingタグで区別)
scoreboard players set @s test.magic.manual_launch 0
execute unless entity @s[tag=equip_proc_casting] run scoreboard players set @s test.magic.manual_launch 1
function test:magic/projectile/cast
scoreboard players set @s test.magic.manual_launch 0
