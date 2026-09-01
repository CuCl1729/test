#> test:buff/save
# @s = バフ保持者。storage test: buff_work.list を個別ストレージへ書き戻す
# 毎tickの走査対象を絞るため、1件でも掛かっていればbuffedタグを付け、空になったら外す

function #oh_my_dat:please

# 最後の1件を取り除いた直後はリスト自体が消えていることがあり、そのままset fromすると
# コピーに失敗して古い内容が残ってしまう。空リストとして書き戻せるよう作り直しておく
execute unless data storage test: buff_work.list[0] run data modify storage test: buff_work.list set value []

data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.buff set from storage test: buff_work.list

tag @s remove buffed
execute if data storage test: buff_work.list[0] run tag @s add buffed
