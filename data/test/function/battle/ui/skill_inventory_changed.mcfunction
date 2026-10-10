#> test:battle/ui/skill_inventory_changed
# @s = インベントリが変化したプレイヤー。トロッコから魔法アイテムを取っていないか即座に確認する

# トロッコは1台をタグで画面ごとに使い回しているため、タイプ選択の判定はtest:tickと同じく
# 他の画面(2択/アクティブスキル/効果/対象選択)のタグが付いていないものだけにかける。
# 除外しないと、2択やアクティブスキル一覧のトロッコで「タイプを取った」「決定した」と誤判定され、
# 中身がタイプ一覧に書き換わってしまう(タグは元のままなので、以降は何を取っても反応しなくなる)
execute as @e[tag=skill_minecart,tag=!skill_effect_minecart,tag=!target_minecart,tag=!skill_category_minecart,tag=!active_skill_minecart,distance=..3] at @s run function test:battle/ui/skill_type_cart_tick
execute as @e[tag=skill_effect_minecart,distance=..3] at @s run function test:battle/ui/skill_effect_cart_tick

advancement revoke @s only test:battle/skill_pick
