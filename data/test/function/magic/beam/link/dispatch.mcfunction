#> test:magic/beam/link/dispatch
# @macro owner/dimension/x/y/z/yaw/pitch (storage test: beam_event_work をそのまま渡される)。
# 空の chain は無視する。持ち主が同じ次元に居て、hp1以上・ダウンしておらず、バトル中でなければ、
# 捕まえた位置・向きのままその場でこの段を始める(持ち主の足元には飛ばさない)
execute unless data storage test: beam_event_work.chain[0] run return 0

data remove storage test: chain_work.next
data modify storage test: chain_work.next set from storage test: beam_event_work.chain[0]
data remove storage test: chain_work.rest
data modify storage test: chain_work.rest set from storage test: beam_event_work.chain
data remove storage test: chain_work.rest[0]
data remove storage test: chain_work.uid
data modify storage test: chain_work.uid set from storage test: beam_event_work.uid
data remove storage test: chain_work.cast
data modify storage test: chain_work.cast set from storage test: beam_event_work.cast
data remove storage test: chain_work.root
execute if data storage test: beam_event_work.root run data modify storage test: chain_work.root set from storage test: beam_event_work.root
data modify storage test: chain_work.fixed_origin set value 1b
data remove storage test: chain_work.action
execute if data storage test: beam_event_work.action run data modify storage test: chain_work.action set from storage test: beam_event_work.action

# distance=0.. は常に真だが、位置を持つ条件を付けることで @a を execute in の次元に絞り込むのに使う
$execute in $(dimension) as @a[scores={OhMyDatID=$(owner),test.status.hp=1..},tag=!downed,distance=0..] unless score @s test.battle.id matches 1.. positioned 0.0 0.0 0.0 positioned ~$(x) ~$(y) ~$(z) rotated $(yaw) $(pitch) run function test:magic/chain/start
