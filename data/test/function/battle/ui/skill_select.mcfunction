#> test:battle/ui/skill_select
# @s = 現在手番のプレイヤー。習得済みの魔法タイプ(自己/投射)から選ばせる

scoreboard players set @s test.battle.skill_select 0
scoreboard players enable @s test.battle.skill_select

scoreboard players set @e[tag=battle_marker,sort=nearest,limit=1] test.battle.awaiting_skill 1

tellraw @s [{text:"使う魔法のタイプを選んでください",color:light_purple}]
tellraw @s [{text:"[自己]",color:aqua,click_event:{action:"run_command",command:"/trigger test.battle.skill_select set 1"}}]
tellraw @s [{text:"[投射]",color:gold,click_event:{action:"run_command",command:"/trigger test.battle.skill_select set 2"}}]
