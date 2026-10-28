#> test:magic/pay
# @s = 詠唱者。magic.player.cost の消費MPを払う。反動(burnout)のぶん高くなり、払った量×10÷魔導掌握が反動に加わる。
# MPが足りなければ何も払わずに fail、払えたら 1 を返す(リアルタイムの test:magic/ とターン制の両方で使う)

execute store result score #cost test.status.mp run data get storage test: magic.player.cost
function test:status/refresh {status:"magic_efficiency"}
scoreboard players operation #cost test.status.magic_efficiency = @s test.status.magic_efficiency

scoreboard players operation #cost test.status.mp += @s test.status.burnout
execute if score @s test.status.mp < #cost test.status.mp run return fail
scoreboard players operation @s test.status.mp -= #cost test.status.mp
scoreboard players operation #cost test.status.mp *= #10 test.constant
scoreboard players operation #cost test.status.mp /= #cost test.status.magic_efficiency
scoreboard players operation @s test.status.burnout += #cost test.status.mp
return 1
