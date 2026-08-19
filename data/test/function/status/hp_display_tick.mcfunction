#> test:status/hp_display_tick
# @s = 敵1体(tag=enemy)。頭上に騎乗させているtext_displayへ表示するHPバーの充填数・表示可否を計算して渡す
# test:arenaディメンション内では戦闘中(battle_member)のみ表示、それ以外の場所では常時表示する

scoreboard players operation #hp_display_cur test.temporary = @s test.status.hp
scoreboard players operation #hp_display_max test.temporary = @s test.status.hp_max

scoreboard players operation #hp_display_filled test.temporary = #hp_display_cur test.temporary
scoreboard players operation #hp_display_filled test.temporary *= #10 test.constant
scoreboard players operation #hp_display_filled test.temporary /= #hp_display_max test.temporary
execute if score #hp_display_cur test.temporary matches ..0 run scoreboard players set #hp_display_filled test.temporary 0

scoreboard players set #hp_display_visible test.temporary 1
execute if dimension test:arena unless entity @s[tag=battle_member] run scoreboard players set #hp_display_visible test.temporary 0

execute on passengers run function test:status/hp_display_render
