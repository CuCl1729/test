#> test:magic/beam/link/frame
# @s = 持続ビームの実体(持ち主プレイヤー本人、または自動ビームの装甲立像)。呼び出し側が持ち主の magic.player を
# 読み込み済みで、#beam_link_delta test.temporary に今回分の経過tickを入れてある(可視猶予中は0)。
# ここで今回ぶんの積み荷(beam_events/link_work)だけを作り直す。magic.player やダメージ/ビームのカウンタには触らない
data modify storage test: beam_events set value []
data modify storage test: link_work set value {}

data modify storage test: link_work.states set value []
execute if data storage test: magic.player.beam_link.states run data modify storage test: link_work.states set from storage test: magic.player.beam_link.states

data modify storage test: link_work.template set value {}
execute if data storage test: magic.player.beam_link run data modify storage test: link_work.template.kind set value "on_land"
execute if data storage test: magic.player.beam_link.interval_ticks run data modify storage test: link_work.template.kind set value "periodic"
execute if data storage test: magic.player.beam_link.interval_ticks run data modify storage test: link_work.template.interval_ticks set from storage test: magic.player.beam_link.interval_ticks
execute if data storage test: magic.player.beam_link.count run data modify storage test: link_work.template.count set from storage test: magic.player.beam_link.count

# 持ち主 = @s がプレイヤー本人なら自分の OhMyDatID、そうでなければ自動ビームの test.owner。
# (自動ビームの実体も OhMyDat の識別を持てるので、OhMyDatID の有無では持ち主/自動を見分けない)
# 実行位置は動かさずに探す
scoreboard players set #beam_link_owner test.temporary 0
execute if entity @s[type=player] run scoreboard players operation #beam_link_owner test.temporary = @s OhMyDatID
execute unless entity @s[type=player] run scoreboard players operation #beam_link_owner test.temporary = @s test.owner

data modify storage test: link_work.meta set value {}
execute store result storage test: link_work.meta.owner int 1 run scoreboard players get #beam_link_owner test.temporary
execute as @a if score @s OhMyDatID = #beam_link_owner test.temporary run data modify storage test: link_work.meta.dimension set from entity @s Dimension

data modify storage test: link_work.meta.uid set value 0
execute if data storage test: magic.player.uid run data modify storage test: link_work.meta.uid set from storage test: magic.player.uid
data modify storage test: link_work.meta.cast set value 0
execute if data storage test: magic.player.cast run data modify storage test: link_work.meta.cast set from storage test: magic.player.cast
execute if data storage test: magic.player.root run data modify storage test: link_work.meta.root set from storage test: magic.player.root
# 自動ビームの実体が待ち行列ごしに出す子は、その実体ぶんの発生源で数える(フレームごとに作り直さない)
execute if data storage test: link_work.meta.root unless entity @s[type=player] run function test:magic/root/source_self
execute if data storage test: link_work.meta.root unless entity @s[type=player] if score #root_self_source test.temporary matches 1.. run data modify storage test: link_work.meta.root.source set from entity @s data.magic_source
execute if data storage test: link_work.meta.root unless data storage test: link_work.meta.root.source run data modify storage test: link_work.meta.root.source set value 0
data modify storage test: link_work.meta.chain set value []
execute if data storage test: magic.player.chain run data modify storage test: link_work.meta.chain set from storage test: magic.player.chain
execute if data storage test: magic.player.data.action run data modify storage test: link_work.meta.action set from storage test: magic.player.data.action
