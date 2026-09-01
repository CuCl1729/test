#> test:buff/apply_entry
# @macro = レジストリ1件 + add(追加するスタック数) = storage test: buff_work.arg
# storage test: buff_work.list を書き換え、結果を #applied / #old_stacks / #new_stacks (test.buff.work)へ返す
#
# 同じidのバフは必ずリスト内に1件だけにする。重ねがけは要素を増やすのではなくstacksを増やす形で
# 表現し、レジストリのmax_stacksで頭打ちにする

# 「既に掛かっているか」はstacksの値ではなく要素の有無で判定する。
# (data getは値が0だと判別できないため。stacksが壊れた要素を新規扱いして二重に積まないようにする)
scoreboard players set #buff_exists test.buff.work 0
$execute if data storage test: buff_work.list[{id:"$(id)"}] run scoreboard players set #buff_exists test.buff.work 1

scoreboard players set #applied test.buff.work 0

scoreboard players set #old_stacks test.buff.work 0
$execute if score #buff_exists test.buff.work matches 1 store result score #old_stacks test.buff.work run data get storage test: buff_work.list[{id:"$(id)"}].stacks
execute if score #buff_exists test.buff.work matches 1 if score #old_stacks test.buff.work matches ..0 run scoreboard players set #old_stacks test.buff.work 1

# 既に掛かっていて再付与の挙動がignoreなら何もしない
execute if score #buff_exists test.buff.work matches 1 if data storage test: buff_work.arg{refresh:"ignore"} run return 0

$scoreboard players set #add_stacks test.buff.work $(add)
execute if score #add_stacks test.buff.work matches ..0 run scoreboard players set #add_stacks test.buff.work 1

# 新規なら指定ぶん、stackなら重ねる、refreshならスタック数は据え置きで時間だけ戻す
scoreboard players operation #new_stacks test.buff.work = #add_stacks test.buff.work
execute if score #buff_exists test.buff.work matches 1 run scoreboard players operation #new_stacks test.buff.work = #old_stacks test.buff.work
execute if score #buff_exists test.buff.work matches 1 if data storage test: buff_work.arg{refresh:"stack"} run scoreboard players operation #new_stacks test.buff.work += #add_stacks test.buff.work

# refreshは段数を足さないが、今より多い段数で掛け直された場合まで据え置くと
# 「強い方を掛けたのに弱いまま」になってしまうため、多い方を採用する
execute if score #buff_exists test.buff.work matches 1 if data storage test: buff_work.arg{refresh:"refresh"} if score #add_stacks test.buff.work > #new_stacks test.buff.work run scoreboard players operation #new_stacks test.buff.work = #add_stacks test.buff.work

# 同じidを何度掛けてもここで頭打ちになる(max_stacksの書き忘れで0段にならないよう最低1は保証する)
$scoreboard players set #max_stacks test.buff.work $(max_stacks)
execute if score #max_stacks test.buff.work matches ..0 run scoreboard players set #max_stacks test.buff.work 1
execute if score #new_stacks test.buff.work > #max_stacks test.buff.work run scoreboard players operation #new_stacks test.buff.work = #max_stacks test.buff.work

# 掛け直しは既存を消してから積み直す(継続時間・タイマー・intervalの進行をまとめてリセットするため)。
# 万一同じidが複数残っていても1件も残らないよう、ループで全部取り除いてから積む
$data modify storage test: buff_work.dedup set value {id:"$(id)"}
function test:buff/remove_duplicates with storage test: buff_work.dedup

$data modify storage test: buff_work.list append value {id:"$(id)",remaining:$(duration),elapsed:0,stacks:1}
execute store result storage test: buff_work.list[-1].stacks int 1 run scoreboard players get #new_stacks test.buff.work

# interval と timers は宣言されているときだけ持たせる(無ければstep側は見に行かない)
execute if data storage test: buff_work.arg.interval run data modify storage test: buff_work.list[-1].next_interval set from storage test: buff_work.arg.interval
execute if data storage test: buff_work.arg.timers run data modify storage test: buff_work.list[-1].timers set from storage test: buff_work.arg.timers

scoreboard players set #applied test.buff.work 1
