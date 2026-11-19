#> test:buff/actor/stat_loop
# 内部。asset.buff.stats を先頭から1件ずつ消費して stat_one へ渡す(#ba_mode が 0 なら受け身の取り分、
# 1 なら参照値を書く)。範囲に収まらなかったら #ba_err が立つのでそこで抜ける

scoreboard players set #ba_err test.buff.work 0
data modify storage test: buff_actor.work.stats set from storage test: asset.buff.stats
function test:buff/actor/stat_take
data remove storage test: buff_actor.work
