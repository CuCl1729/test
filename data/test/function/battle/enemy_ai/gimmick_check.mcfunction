#> test:battle/enemy_ai/gimmick_check
# @s = 手番の敵。@macro id/weight: ギミック1件ぶん(enemy_ai_work.gimmick_entryとして展開済み)。
# hp_below/cooldownは省略可
# 現在のクールダウン値で今回使えるか判定してから、残っていれば1減らして書き戻す。
# (判定を先にすることで「宣言したcooldownの回数ぶん手番を飛ばす」という直感的な意味になる)

scoreboard players set #gimmick_ok test.buff.work 1

# HP条件(宣言されていなければ無条件で満たす。101はHP%(0〜100)より必ず大きいのでその場合は常に不成立)
scoreboard players set #hp_below test.buff.work 101
execute store result score #hp_below test.buff.work run data get storage test: enemy_ai_work.gimmick_entry.hp_below
execute if score #hp_percent test.buff.work >= #hp_below test.buff.work run scoreboard players set #gimmick_ok test.buff.work 0

# クールダウン(宣言が無ければ0=常に使える)
scoreboard players set #cooldown test.buff.work 0
$execute store result score #cooldown test.buff.work run data get entity @s data.ai.cooldowns.$(id)
execute if score #cooldown test.buff.work matches 1.. run scoreboard players set #gimmick_ok test.buff.work 0
execute if score #cooldown test.buff.work matches 1.. run scoreboard players remove #cooldown test.buff.work 1
$execute store result entity @s data.ai.cooldowns.$(id) int 1 run scoreboard players get #cooldown test.buff.work

execute if score #gimmick_ok test.buff.work matches 1 run data modify storage test: enemy_ai_work.candidates append from storage test: enemy_ai_work.gimmick_entry
