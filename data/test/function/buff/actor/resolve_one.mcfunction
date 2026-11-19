#> test:buff/actor/resolve_one
# 内部。@s = 見つかった発生元。今の参照値を取る。範囲に収まらなかったときの {ok:0b} はそのまま返す
# (発生元がいたのに計算が失敗したことを、控えてあった値で上書きして隠さない)

# arg.caster_uuid があるなら、IDを使い回した別人は「見つからなかった」扱いにする
# (身元が違うだけで、生きている発生元の計算の失敗を隠すわけではない)
scoreboard players set #bi_match test.buff.work 1
execute if data storage test: buff_actor.arg.caster_uuid run data modify storage test: buff_identity.arg set value {}
execute if data storage test: buff_actor.arg.caster_uuid run data modify storage test: buff_identity.arg.uuid set from storage test: buff_actor.arg.caster_uuid
execute if data storage test: buff_actor.arg.caster_uuid run function test:buff/identity/matches with storage test: buff_identity.arg
execute if score #bi_match test.buff.work matches 0 run return 0

function test:buff/actor/reference
scoreboard players set #ba_live test.buff.work 1
execute if data storage test: buff_actor.result{ok:1b} run data modify storage test: buff_actor.result.live set value 1b
