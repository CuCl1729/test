#> test:job/skill/bundle_check_cursor
# @s = カーソルに印アイテムを持っているプレイヤー(インベントリ画面でバンドルを右クリックして取り出した)。
# インベントリ画面での取り出しは「次に使うスキルを選ぶ操作」として扱い、発動はさせずに
# そのスキルをバンドルの先頭へ移す。
# カーソルのアイテムはプレイヤーのNBTに含まれないため、一旦0 -64 0(オーバーワールド)の
# シュルカーボックスへ写してからcustom_dataを読む。player.cursorはクリエイティブモードでは使えない

execute in minecraft:overworld run item replace block 0 -64 0 container.0 from entity @s player.cursor
execute in minecraft:overworld run data modify storage test: job_work.consume_entry set from block 0 -64 0 Items[{Slot:0b}].components."minecraft:custom_data".test
clear @s *[custom_data~{test:{skill_marker:1b}}]

function #oh_my_dat:please
function test:job/skill/bundle_pick_front with storage test: job_work.consume_entry
