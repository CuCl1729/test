#> test:buff/native/evaluate
# 純粋。storage test: buff_native.arg = {ledger:[段のまとまり,…]} から、
# いまネイティブの属性修飾子に入れるべき合計を出す。実体・正本・得点・通知には一切触れない。
#
#   成功: storage test: buff_native.result =
#     {ok:1b,speed:<内部整数の和>,jump:<内部整数の和>,speed_present:<bool>,jump_present:<bool>} で 1
#   失敗: {ok:0b,error:"out_of_range"} で 0(和が32bitに収まらない / 行が合うのに per_stack が無い)
#
#   数えるのは固定済みの unit.eff だけ。イベントの件数も、いまのレジストリの定義も見ない
#   (件数は「この取引で起きたこと」で、合計ではない。レジストリは後から書き換えられる)。
#   作業域は buff_native.work、buff_math は呼び先の作業域として上書きされる

data remove storage test: buff_native.result
data modify storage test: buff_native.work set value {groups:[],speed:[0],jump:[0]}
execute if data storage test: buff_native.arg.ledger[0] run data modify storage test: buff_native.work.groups set from storage test: buff_native.arg.ledger

scoreboard players set #bn_speed_n test.buff.work 0
scoreboard players set #bn_jump_n test.buff.work 0
scoreboard players set #bn_bad test.buff.work 0
execute if data storage test: buff_native.work.groups[0] run function test:buff/native/group_loop

# 断る側を先に置いておく。途中で抜けても半端な結果は見せない
data modify storage test: buff_native.result set value {ok:0b,error:"out_of_range"}
execute if score #bn_bad test.buff.work matches 1 run return 0

# 和は初項0を入れた一覧で取る(寄与が無いときも値0として成立させるため)
data modify storage test: buff_math.arg.values set from storage test: buff_native.work.speed
function test:buff/math/addn with storage test: buff_math.arg
execute if score #math_ok test.buff.work matches 0 run return 0
scoreboard players operation #bn_speed test.buff.work = #math_sum test.buff.work

data modify storage test: buff_math.arg.values set from storage test: buff_native.work.jump
function test:buff/math/addn with storage test: buff_math.arg
execute if score #math_ok test.buff.work matches 0 run return 0
scoreboard players operation #bn_jump test.buff.work = #math_sum test.buff.work

data modify storage test: buff_native.result set value {ok:1b,speed:0,jump:0,speed_present:0b,jump_present:0b}
execute store result storage test: buff_native.result.speed int 1 run scoreboard players get #bn_speed test.buff.work
execute store result storage test: buff_native.result.jump int 1 run scoreboard players get #bn_jump test.buff.work
execute if score #bn_speed_n test.buff.work matches 1.. run data modify storage test: buff_native.result.speed_present set value 1b
execute if score #bn_jump_n test.buff.work matches 1.. run data modify storage test: buff_native.result.jump_present set value 1b
return 1
