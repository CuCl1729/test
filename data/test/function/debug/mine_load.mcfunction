#> test:debug/mine_load
# @s = プレイヤー。@macro mode: add(読み込む) / remove(やめる)。
# 全鉱山の範囲を、test:action と test:turn の両方で forceload する(またはやめる)。
# 鉱脈を置く・消す・調べるデバッグ機能が、もう片方のマップのアマスタを確実に扱えるようにするため。
# forceload はワールドに保存されるので、作業が終わったらやめる。読み込んだ直後は、エンティティが出てくるまで少しかかる

$data modify storage test: debug_work.mine_load_mode set value "$(mode)"
data modify storage test: debug_work.mine_load_queue set from storage test: asset.mine_ids
function test:debug/mine_load_loop
execute if data storage test: debug_work{mine_load_mode:"add"} run tellraw @s [{text:"鉱山を読み込んだ(両マップ)。終わったら ",color:gray},{text:"[やめる]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/mine_load {mode:remove}"}}]
execute if data storage test: debug_work{mine_load_mode:"remove"} run tellraw @s [{text:"鉱山の読み込みをやめた",color:gray}]
