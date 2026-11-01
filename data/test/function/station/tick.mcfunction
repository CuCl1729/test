#> test:station/tick
# @s = ステーションのマーカー(test:tickから、プレイヤーが近くにいる間だけ毎tick。実行位置は樽)。
# 種類ごとの違いは asset.station.<data.station.id>(init/asset/station)にあり、ここは全ステーション共通:
# 樽の確認 → 飾り → モードに入る → モード切り替えボタン → 今のモード(ボタン型のcraftか、独自画面のmain)

execute unless block ~ ~ ~ barrel run return run function test:station/no_barrel with entity @s data.station

# 樽の真下のホッパー(とホッパー付きトロッコ)は、樽の中身(作った結果・ボタン・板ガラス)を吸い出すので取り除く(その場に落とす)
execute if block ~ ~-1 ~ minecraft:hopper run setblock ~ ~-1 ~ air destroy
execute positioned ~-0.5 ~-1.5 ~-0.5 as @e[type=hopper_minecart,dx=0,dy=0,dz=0] at @s run function test:station/remove_hopper_cart

# 飾り(名前・目印・GUIタイトル)が付いていないステーションに付ける(移行したものにも効くよう毎tick確認)
execute unless entity @s[tag=station_decorated] run function test:station/decorate_by_id with entity @s data.station
# 明るさを固定する前に付けた飾りを、一度だけ直す(飾りは樽の中にいるので、固定しないと真っ暗に描かれる)
execute unless entity @s[tag=station_bright] run function test:station/brighten

# 設置した直後・移行した直後は、まだモードに入っていない
# (空きスロットを埋める印 keep が入る前に置いたもの・入ったものも、ここで入り直す)
execute unless data entity @s data.station.keep run function test:station/enter_mode

# モード切り替え(スロット20のボタンを取ったら次のモードへ)。同じtickに前のモードの処理が動かないよう、ここで終える
execute if entity @s[tag=station_multi] unless data block ~ ~ ~ Items[{Slot:20b}] run return run function test:station/next_mode

# ボタン型: スロット26の緑ガラスを取ったら作る
execute if data entity @s data.station.craft unless items block ~ ~ ~ container.26 lime_stained_glass_pane run function test:station/press
# 独自の画面: 毎tick呼ぶ
execute if data entity @s data.station.main run function test:station/run_main with entity @s data.station

# 使わないスロットを灰色の板ガラスで埋める
function test:station/fill_empty

# 取っても意味の無いUIアイテム(モード切り替え・作るボタン・板ガラス)は、手元に残らないよう回収する
clear @a[distance=..6] *[custom_data~{test:{station_ui:1b}}]
clear @a[distance=..6] *[custom_data~{test:{button:1b}}]
