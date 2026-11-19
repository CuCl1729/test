#> test:equip/proc/cast
# @s = プレイヤー(at @s)。equip_work.proc_queue[0].magic(防具に付けた魔法)を、手に持って唱えたときと同じ
# test:magic/ で唱える。MP・バーンアウトの判定と支払いもその中で行われ、足りなければ何も起きない。
# 4部位のセット効果(magic_cast)は自動発動の魔法にもかかるが、自動発動の予約はequip_proc_castingタグで止める

data modify storage test: magic.player set from storage test: equip_work.proc_queue[0].magic

# 継続の魔法は「押し続ける」入力が要るので、自動発動の枠からは唱えない
# (押し始めの判定を通らないだけでなく、プレイヤー自身の押し続けの記録を乱すため)
execute if data storage test: magic.player.type_flags{continuous:1b} run return 0

tag @s add equip_proc_casting
function test:magic/
tag @s remove equip_proc_casting
