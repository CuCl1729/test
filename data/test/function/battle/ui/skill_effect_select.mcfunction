#> test:battle/ui/skill_effect_select
# @s = 現在手番のプレイヤー(チャット式)。選択済みのタイプに応じて、習得済みの効果から
# 今回の詠唱で使う組み合わせを選ばせる(複数選択可・トグル式)

function #oh_my_dat:please
data remove storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.magic.select.effect

scoreboard players set @s test.battle.skill_effect 0
scoreboard players enable @s test.battle.skill_effect

scoreboard players set @e[tag=battle_marker,sort=nearest,limit=1] test.battle.awaiting_skill 3

function test:battle/ui/skill_effect_display
