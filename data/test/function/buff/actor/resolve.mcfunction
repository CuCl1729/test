#> test:buff/actor/resolve
# @s = 効果を受ける側(recipient)。storage test: buff_actor.arg =
#   {caster:<発生元の OhMyDatID>,caster_uuid?:<発生元の本物の UUID / IntArray>,last_refs:{…}}
#   caster は引き当てる鍵。caster_uuid があるときだけ、IDと UUID の両方が合う生きた実体を
#   発生元と認める(死んだ非プレイヤーのIDは使い回されるため)。無いときは今までどおり
#   IDだけで探す。結果の caster_uuid は、生きていれば本物、落ちたときは渡されたものの控え
#   発生元に手が届くなら、その人の今の参照値を取る。届かないなら控えてあった last_refs を使う
#   (打ち上げ/発生元を作った時点で控えたもの。定数だけの古い効果では空のこともある。
#    参照元がいないことだけを理由に効果を捨てない。一度も控えていない参照を式が使っていたら
#    test:buff/eval が missing_reference で教える)
#   storage test: buff_actor.result = {ok:1b,live:1b|0b,refs:{…}} / {ok:0b,error:"out_of_range"}
#   live は「今の発生元から取れたか」。この単位では利用者の関数は動かさない
# 呼び出し元の文脈は壊さない: buff_work・buff_ledger とイベントの文脈には触らず、
# 他人の参照値を取ったあとは受け手の OhMyDat のカーソルを戻す

scoreboard players set #ba_live test.buff.work 0
execute if data storage test: buff_actor.arg.caster run function test:buff/actor/resolve_find with storage test: buff_actor.arg

execute if score #ba_live test.buff.work matches 0 run data modify storage test: buff_actor.result set value {ok:1b,live:0b,refs:{}}
execute if score #ba_live test.buff.work matches 0 if data storage test: buff_actor.arg.last_refs run data modify storage test: buff_actor.result.refs set from storage test: buff_actor.arg.last_refs
# 届かなかったときも、渡された発生元の身元はそのまま残す(あとで誰の仕業かを言うため)
execute if score #ba_live test.buff.work matches 0 if data storage test: buff_actor.arg.caster_uuid run data modify storage test: buff_actor.result.caster_uuid set from storage test: buff_actor.arg.caster_uuid

# 他人として参照値を取る間に OhMyDat のカーソルが動いているので、受け手に戻しておく
# (test:buff/load・save と同じく、プレイヤーでも敵でも個別ストレージを持つので種類を問わない)
function #oh_my_dat:please
