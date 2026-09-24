#> test:battle/ui/skill_category_select
# @s = 詠唱者(チャット式)。魔法と職業/剣のアクティブスキルの両方が使える場合、先に2択させる

scoreboard players set @s test.battle.skill_category 0
scoreboard players enable @s test.battle.skill_category

scoreboard players set @e[tag=battle_marker,sort=nearest,limit=1] test.battle.awaiting_skill 5

tellraw @s [{text:"1: 魔法",color:aqua,click_event:{action:"run_command",command:"/trigger test.battle.skill_category set 1"}}]
tellraw @s [{text:"2: アクティブスキル",color:gold,click_event:{action:"run_command",command:"/trigger test.battle.skill_category set 2"}}]
