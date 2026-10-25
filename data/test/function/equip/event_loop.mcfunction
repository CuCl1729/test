#> test:equip/event_loop
# @macro event: 処理中のイベント。一覧を先頭から見て、eventが一致する効果だけを振り分ける

$execute unless data storage test: equip_work.event_queue.$(event)[0] run return 0

$data modify storage test: equip_work.current set from storage test: equip_work.event_queue.$(event)[0]
$data remove storage test: equip_work.event_queue.$(event)[0]

$execute if data storage test: equip_work.current{event:"$(event)"} run function test:equip/effect_dispatch with storage test: equip_work.current

$function test:equip/event_loop {event:"$(event)"}
