#> test:battle/ui/skill_effect_cast
# @s = 詠唱を確定したプレイヤー。選択済みのタイプと効果を元に唱える

scoreboard players set @e[tag=battle_marker,sort=nearest,limit=1] test.battle.awaiting_skill 0

function #oh_my_dat:please
data modify storage test: registry_work.cast.delivery set from storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.magic.select.delivery

# タイプを増やしてもここを触らずに済むよう、battle/action/skill_cast/<id> へマクロで委譲する
function test:battle/ui/skill_cast_dispatch with storage test: registry_work.cast
