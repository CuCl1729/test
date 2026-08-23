#> test:battle/ui/skill_effect_display
# @s = 効果選択中のプレイヤー(チャット式)。現在の選択状態を表示し直す(トグルの度に呼ばれる)
# レジストリ(test:init/asset/magic/effects)を走査するので、効果を増やしてもここは無改修

tellraw @s [{text:"使う効果を選んでください(複数選択可)",color:light_purple}]

function #oh_my_dat:please
function test:battle/ui/skill_effect_categories

scoreboard players set #effect_index test.temporary 1
function test:magic/registry/queue_effects
function test:battle/ui/skill_effect_display_loop

tellraw @s [{text:"[詠唱する]",color:aqua,click_event:{action:"run_command",command:"/trigger test.battle.skill_effect set 99"}}]
