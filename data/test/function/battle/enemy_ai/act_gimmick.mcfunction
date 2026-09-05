#> test:battle/enemy_ai/act_gimmick
# @s = 手番の敵。@macro id/weight/cooldown(省略可): 選ばれたギミック1件ぶん
# クールダウンを(宣言値、省略時は1)記録してから、ギミック本体(test:battle/enemy_ai/gimmick/<id>)を呼ぶ。
# ギミック本体は行動の最後に必ず攻撃/防御と同様 test:battle/turn_end に辿り着くこと
# (test:battle/action/attackやdefendを呼べば自動的に満たされる)

scoreboard players set #cooldown_value test.buff.work 1
execute store result score #cooldown_value test.buff.work run data get storage test: enemy_ai_work.dispatch_entry.cooldown
execute if score #cooldown_value test.buff.work matches ..0 run scoreboard players set #cooldown_value test.buff.work 1

$execute store result entity @s data.ai.cooldowns.$(id) int 1 run scoreboard players get #cooldown_value test.buff.work

$function test:battle/enemy_ai/gimmick/$(id)
