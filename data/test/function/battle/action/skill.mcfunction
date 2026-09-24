#> test:battle/action/skill
# @s = 行動を選んだ詠唱者(チャット式)。使える魔法タイプと職業/剣のアクティブスキル、
# 両方の有無を見て振り分ける。魔法しか使えない場合はtest:battle/action/skill_magic_onlyへ渡し、
# 従来と完全に同じ挙動を維持する(回帰防止)

function test:battle/action/skill_category_count

execute if score #has_magic test.temporary matches 0 if score #has_active_skill test.temporary matches 0 run tellraw @s [{text:"使えるスキルがありません",color:gray}]
execute if score #has_magic test.temporary matches 0 if score #has_active_skill test.temporary matches 0 run return run function test:battle/turn_end

execute if score #has_magic test.temporary matches 1 if score #has_active_skill test.temporary matches 0 run return run function test:battle/action/skill_magic_only

execute if score #has_magic test.temporary matches 0 if score #has_active_skill test.temporary matches 1 run return run function test:battle/action/active_skill_select

function test:battle/ui/skill_category_select
