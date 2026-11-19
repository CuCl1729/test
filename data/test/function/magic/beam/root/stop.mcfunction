#> test:magic/beam/root/stop
# @s = 持ち主。register で足した仮想の保持(beam_root)だけを外す。元帳(magic_beam_roots)はここでは触らない
# (他の子の実体ぶんの参照が残っていれば、次の watch が片付ける)。実際のビームのフラグはここでは変えない
# (呼び出し元の test:magic/beam/stop が行う)。
# スクラッチは beam_root_work.stop 以下だけを使う: watch_one が回している最中に呼ばれても
# watch_entry / watch_in / keep を壊さないため
execute unless score @s test.magic.beam_root matches 1.. run return 0

execute store result storage test: beam_root_work.stop.id int 1 run scoreboard players get @s test.magic.beam_root
function test:magic/root/unhold with storage test: beam_root_work.stop
scoreboard players set @s test.magic.beam_root 0
return 1
