#> test:battle/ui/active_skill_resolve
# @s = アクティブスキルを選んだプレイヤー(チャット式)。選ばれた番号と、
# battle.temporary.active_skill_slotの並び順を先頭から数えて突き合わせ、一致した1件を発動する
# (トリガー値=登録順の番号なので、direct indexingではなく数えながら突き合わせる。skill_resolveと同じ考え方)

scoreboard players operation #target_index test.temporary = @s test.battle.active_skill_select
scoreboard players set @s test.battle.active_skill_select 0
scoreboard players set @e[tag=battle_marker,sort=nearest,limit=1] test.battle.awaiting_skill 0

data modify storage test: registry_work.active_resolve_queue set from storage test: battle.temporary.active_skill_slot
scoreboard players set #active_resolve_index test.temporary 0

function test:battle/ui/active_skill_resolve_loop
