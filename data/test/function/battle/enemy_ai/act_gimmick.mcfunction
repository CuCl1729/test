#> test:battle/enemy_ai/act_gimmick
# @s = 手番の敵。@macro id/weight/cooldown(省略可)/params: 選ばれたギミック1件ぶん
# クールダウンを(宣言値、省略時は1)記録してから、ギミック本体(test:battle/enemy_ai/gimmick/<id>)を params を
# マクロ引数にして呼ぶ(強さなどの数値はシートの「敵のギミック」タブの params に書き、関数には書かない)。
# ギミック本体は行動の最後に必ず攻撃/防御と同様 test:battle/turn_end に辿り着くこと
# (test:battle/action/attackやdefendを呼べば自動的に満たされる)

scoreboard players set #cooldown_value test.buff.work 1
execute store result score #cooldown_value test.buff.work run data get storage test: enemy_ai_work.dispatch_entry.cooldown
execute if score #cooldown_value test.buff.work matches ..0 run scoreboard players set #cooldown_value test.buff.work 1

$execute store result entity @s data.ai.cooldowns.$(id) int 1 run scoreboard players get #cooldown_value test.buff.work

# params の無い宣言(params の列ができる前に召喚された敵)でも呼べるよう、空にしておく
execute unless data storage test: enemy_ai_work.dispatch_entry.params run data modify storage test: enemy_ai_work.dispatch_entry.params set value {}
$function test:battle/enemy_ai/gimmick/$(id) with storage test: enemy_ai_work.dispatch_entry.params
