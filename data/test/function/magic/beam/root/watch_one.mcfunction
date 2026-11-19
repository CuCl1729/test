#> test:magic/beam/root/watch_one
# @macro owner/root/dimension: beam_root_work.watch_entry に乗っている1件が、まだ有効か確かめる。
# 有効(元帳が保持中 held かつ、その次元にいる持ち主が今もこのルートのビームを出している)なら keep に残す。
# 無効なら、持ち主が「今まさにこのルートの」ビームを出していたときだけ止める(ownerIDとbeam_rootの両方で
# 絞るので、持ち主が切り替えた新しいビームを古い記録が止めてしまわない)。元帳の仮想の保持も外す(重複安全)
scoreboard players set #beam_root_valid test.temporary 0
$execute if data storage test: magic_roots[{id:$(root),held:1b}] in $(dimension) as @a[distance=0..,scores={OhMyDatID=$(owner),test.magic.beam=1,test.magic.beam_root=$(root),test.status.hp=1..},tag=!downed] unless score @s test.battle.id matches 1.. run scoreboard players set #beam_root_valid test.temporary 1

execute if score #beam_root_valid test.temporary matches 1 run data modify storage test: beam_root_work.keep append from storage test: beam_root_work.watch_entry
execute if score #beam_root_valid test.temporary matches 1 run return 1

$execute as @a[scores={OhMyDatID=$(owner),test.magic.beam_root=$(root)}] at @s run function test:magic/beam/stop
data modify storage test: beam_root_work.watch_entry.id set from storage test: beam_root_work.watch_entry.root
function test:magic/root/unhold with storage test: beam_root_work.watch_entry
return 0
