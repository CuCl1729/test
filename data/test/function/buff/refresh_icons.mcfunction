#> test:buff/refresh_icons
# @s = バフ保持者。頭上のHP表示(騎乗しているtext_display)へ、掛かっているバフのアイコン列をキャッシュする
# storage test: buff_work.list が最新である前提(apply/remove/clear/step の書き戻し直後に呼ぶ)
#
# 毎tick oh_my_dat:please を呼んで組み立て直すのは重すぎるため、結果をtext_display自身のNBTへ置き、
# 毎tickの描画(status/hp_display_render)はそれを連結するだけにしている
# プレイヤーの常時表示は今のところ用意していない(付与・終了時のチャット通知のみ)

execute if entity @s[type=player] run return 0

data modify storage test: buff_work.icons set value []
data modify storage test: buff_work.icon_queue set from storage test: buff_work.list
function test:buff/refresh_icons_loop

execute on passengers if entity @s[tag=hp_display] run data modify entity @s data.buff_icons set value []
execute on passengers if entity @s[tag=hp_display] if data storage test: buff_work.icons[0] run data modify entity @s data.buff_icons set from storage test: buff_work.icons
