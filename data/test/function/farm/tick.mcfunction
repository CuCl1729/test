#> test:farm/tick
# @s = 魔法作物(interaction。test:tick の1秒クロックから、工場のディメンションのものだけ。実行位置も@s)。
# 下が耕地でなくなっていたら(水で流された・掘られた・踏まれたなど)種を落として消え、そうでなければ育てる。
# 区画は forceload されているので、誰もいなくても育つ

execute unless block ~ ~-1 ~ minecraft:farmland run return run function test:farm/pop with entity @s data.crop
function test:farm/grow with entity @s data.crop
