#> test:buff/load
# @s = バフ保持者。個別ストレージのバフ一覧を storage test: buff_work.list へ読み込む
# プレイヤーでも敵でも同じ経路が使えるよう、保持先はoh_my_datの個別ストレージにしている
# (oh_my_dat:sys/allocateは@sの種類を問わずIDを振るため。敵が死んだときは test:tick の
#  scoreboard players reset @e[tag=kill] でOhMyDatIDごと消えるのでGCがスロットを回収する)

function #oh_my_dat:please

data modify storage test: buff_work.list set value []
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.buff[0] run data modify storage test: buff_work.list set from storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.buff
