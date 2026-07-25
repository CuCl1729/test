#> test:battle/setup_arena_marker
# 呼び出し元で in test:arena + positioned 済み

summon marker ~ ~ ~ {Tags:[battle_marker]}
scoreboard players operation @e[tag=battle_marker,sort=nearest,limit=1] test.battle.id = #battle test.battle.next_id
scoreboard players set @e[tag=battle_marker,sort=nearest,limit=1] test.battle.current_turn 1
scoreboard players set @e[tag=battle_marker,sort=nearest,limit=1] test.battle.member_count 0