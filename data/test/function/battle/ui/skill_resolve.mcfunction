#> test:battle/ui/skill_resolve
# @s = タイプ選択(トグル/決定)を行ったプレイヤー(チャット式)

scoreboard players operation #skill_select test.battle.skill_select = @s test.battle.skill_select
scoreboard players set @s test.battle.skill_select 0

# 99は決定ボタン
execute if score #skill_select test.battle.skill_select matches 99 run return run function test:battle/ui/skill_type_confirm

# それ以外はレジストリの並び順の番号なので、対応するタイプの選択状態をトグルする
scoreboard players set #type_index test.temporary 1
function test:magic/registry/queue_types
function test:battle/ui/skill_type_toggle_loop

scoreboard players enable @s test.battle.skill_select
function test:battle/ui/skill_type_display
