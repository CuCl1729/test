#> test:debug/quest_list
# @s = プレイヤー。全部のクエストの状態(サブは自分の、メインは全員共通)と、受ける・段階を進める・完了にする・未受注に戻すボタンを出す

function #oh_my_dat:please
tellraw @s {text:"― クエスト(デバッグ) ―",color:"gold"}
data modify storage test: debug_work.give_queue set from storage test: asset.quest_ids
function test:debug/quest_list_loop
