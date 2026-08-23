#> test:battle/ui/skill_type_select
# @s = 現在手番のプレイヤー(チャット式)。習得済みの魔法タイプをトグル式で選ばせる
# (効果選択と同じ「複数選んで最後に決定」の形。組み合わせの可否は決定時に検証する)

function #oh_my_dat:please
data remove storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.magic.select

scoreboard players set @s test.battle.skill_select 0
scoreboard players enable @s test.battle.skill_select

scoreboard players set @e[tag=battle_marker,sort=nearest,limit=1] test.battle.awaiting_skill 1

function test:battle/ui/skill_type_display
