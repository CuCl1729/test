#> test:battle/action/skill_cast/build_effect_repeat
# @macro id/folder: 効果id と アセット関数の置き場所
# #effect_repeatの回数だけアセット関数を呼ぶ再帰

$function test:asset/magic/$(folder)/$(id)

scoreboard players remove #effect_repeat test.temporary 1
$execute if score #effect_repeat test.temporary matches 1.. run function test:battle/action/skill_cast/build_effect_repeat {id:"$(id)",folder:"$(folder)"}
