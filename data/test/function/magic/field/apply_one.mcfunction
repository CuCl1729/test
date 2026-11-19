#> test:magic/field/apply_one
# @s = 掛ける相手。@macro id / stacks(+ 任意で chance)。この場の名前で1件掛ける。
#
# 段数の引き算で後始末するのではなく、バフ側に「この場が掛けたぶん」として持たせる
# (test:buff/apply_source)。だから出るときは同じ名前のぶんだけを外せばよく、
# ほかの魔法や別の場が独立に掛けた同じidの効果は、段数も残り時間も一切触らない
scoreboard players set #chance test.buff.work 100
execute if data storage test: field_work.pending_one.chance store result score #chance test.buff.work run data get storage test: field_work.pending_one.chance
scoreboard players set #roll test.buff.work 0
execute store result score #roll test.buff.work run function test:rng/roll {key:"buff_chance",min:1,max:100}
execute if score #roll test.buff.work > #chance test.buff.work run return 0

data remove storage test: buff_work.src_arg
$data modify storage test: buff_work.src_arg set value {id:"$(id)",stacks:$(stacks),key:"f0",duration:1,initial:1b}
data modify storage test: buff_work.src_arg.duration set from storage test: field_work.secs
function test:magic/field/src_key with storage test: field_work

function test:buff/apply_source with storage test: buff_work.src_arg

$data modify storage test: field_work.granted append value {id:"$(id)"}
