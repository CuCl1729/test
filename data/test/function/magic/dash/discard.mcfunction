#> test:magic/dash/discard
# @s = 始末するダッシュ代理。saddleを先に外してドロップを防ぎ、mannequinは即killしても死亡演技のぶん
# 残ることがあるため、先にDeathTimeを演技終了ぶんまで進めてから消す。
tag @a remove magic_dash_owner
tag @s remove magic_dash_proxy
tag @s remove dash_join
item replace entity @s saddle with air
data merge entity @s {DeathTime:19s}
kill @s
