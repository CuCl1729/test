#> test:battle/ui/skill_effect_select
# @s = 現在手番のプレイヤー(チャット式)。test.battle.skill_type(1=自己/2=投射)に応じて
# 習得済みの効果から今回の詠唱で使う組み合わせを選ばせる(複数選択可・トグル式)

scoreboard players set @s test.magic.select.fire 0
scoreboard players set @s test.magic.select.atk 0
scoreboard players set @s test.magic.select.heal 0
scoreboard players set @s test.magic.select.gravity 0

scoreboard players set @s test.battle.skill_effect 0
scoreboard players enable @s test.battle.skill_effect

scoreboard players set @e[tag=battle_marker,sort=nearest,limit=1] test.battle.awaiting_skill 3

function test:battle/ui/skill_effect_display
