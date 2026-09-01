#> test:buff/remove_duplicates
# @macro id: 取り除くバフid。buff_work.list から同じidの要素が無くなるまで取り除く
# 通常は1件しか無いが、「同じidは必ず1件」という前提をここで保証しておくことで、
# 万一二重に積まれても重ねがけの上限をすり抜けられないようにする

$execute unless data storage test: buff_work.list[{id:"$(id)"}] run return 0

$data remove storage test: buff_work.list[{id:"$(id)"}]

$function test:buff/remove_duplicates {id:"$(id)"}
