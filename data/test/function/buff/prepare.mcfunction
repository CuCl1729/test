#> test:buff/prepare
# @s = 効果を受ける側(recipient)。storage test: buff_prepare.arg =
#   {id:"<バフid>",caster:<発生元の OhMyDatID / 無いなら -1>,caster_uuid?:<発生元の本物の UUID>,last_refs:{…}}
#   caster_uuid を渡すと、IDが同じでも身元が違う実体は発生元と認めず last_refs に落ちる。
#   成功したときは actor が決めた身元を eff.caster_uuid に凍らせる(caster は今までどおりID)
#   コンパイル済みの効果行を「掛けた時点の発生元」に固定した写しにする。あとで台帳が受理したときに
#   そのまま配るためのもので、この単位では台帳・ステータス・利用者の関数には一切触らない
#
#   成功: storage test: buff_prepare.result = {ok:1b,id,caster,refs:{…},eff:{effects:[控えた行]},
#     duration,max_stacks,policy,interval?,timers?,params:{…}} を一度に書いて1を返す
#   失敗: {ok:0b,error:"unknown_buff"|"missing_reference"|"out_of_range"|"gear_unavailable"} だけを書いて0を返す
#     (refs・eff・メタ情報が中途半端に残ることはない)
#
# 効果行は値の写しで、あとから引く遅延参照ではない。スプレッドシートを直して再生成しても、
# 既に掛かっている分の関数パス・resource・type・行の数が変わらないようにするため。
# 行番号(row)は定義内の0始まりの並び順で、同じ種類の行を別々に宣言したものは別々のまま残る

scoreboard players set #bp_i test.buff.work 0
data remove storage test: buff_prepare.result
data modify storage test: buff_prepare.work set value {rows:[],out:[],refs:{}}

# 知らないidは、生きている発生元を触る前に断る
execute unless data storage test: buff_prepare.arg.id run data modify storage test: buff_prepare.result set value {ok:0b,error:"unknown_buff"}
execute if data storage test: buff_prepare.arg.id run function test:buff/prepare/lookup with storage test: buff_prepare.arg
execute if data storage test: buff_prepare.result run return run function test:buff/prepare/end

# 発生元の参照値は prepare ごとに一度だけ取る(行ごとには取らない)。
# 受け手の OhMyDat のカーソルは actor/resolve が戻してくれる
data modify storage test: buff_actor.arg set value {caster:-1}
execute if data storage test: buff_prepare.arg.caster run data modify storage test: buff_actor.arg.caster set from storage test: buff_prepare.arg.caster
execute if data storage test: buff_prepare.arg.caster_uuid run data modify storage test: buff_actor.arg.caster_uuid set from storage test: buff_prepare.arg.caster_uuid
execute if data storage test: buff_prepare.arg.last_refs run data modify storage test: buff_actor.arg.last_refs set from storage test: buff_prepare.arg.last_refs
function test:buff/actor/resolve

execute if data storage test: buff_actor.result{ok:0b} run data modify storage test: buff_prepare.result set value {ok:0b}
execute if data storage test: buff_actor.result{ok:0b} run data modify storage test: buff_prepare.result.error set from storage test: buff_actor.result.error
execute if data storage test: buff_prepare.result run return run function test:buff/prepare/end

data modify storage test: buff_prepare.work.refs set from storage test: buff_actor.result.refs

# 数値行(stat/heal/damage)はここで一度だけ評価する。1行でも失敗したら prepare 全体を失敗させる
execute if data storage test: buff_prepare.work.def.effects run data modify storage test: buff_prepare.work.rows set from storage test: buff_prepare.work.def.effects
function test:buff/prepare/row_loop
execute if data storage test: buff_prepare.result run return run function test:buff/prepare/end

# 成功の結果はスクラッチで組み立ててから一度だけ移す(中途半端なresultを見せないため)
data modify storage test: buff_prepare.work.res set value {ok:1b,caster:-1,eff:{effects:[]},policy:"independent",params:{}}
data modify storage test: buff_prepare.work.res.id set from storage test: buff_prepare.arg.id
execute if data storage test: buff_prepare.arg.caster run data modify storage test: buff_prepare.work.res.caster set from storage test: buff_prepare.arg.caster
data modify storage test: buff_prepare.work.res.refs set from storage test: buff_prepare.work.refs
data modify storage test: buff_prepare.work.res.eff.effects set from storage test: buff_prepare.work.out
# 発生元の身元も eff に凍らせる(IDは使い回されるので、あとで誰の仕業かを言えるのは UUID だけ)
execute if data storage test: buff_actor.result.caster_uuid run data modify storage test: buff_prepare.work.res.eff.caster_uuid set from storage test: buff_actor.result.caster_uuid

# メタ情報はレジストリの写し。レジストリに無いキーは結果にも出さない(ここで値を作らない)
execute if data storage test: buff_prepare.work.def.duration run data modify storage test: buff_prepare.work.res.duration set from storage test: buff_prepare.work.def.duration
execute if data storage test: buff_prepare.work.def.max_stacks run data modify storage test: buff_prepare.work.res.max_stacks set from storage test: buff_prepare.work.def.max_stacks
execute if data storage test: buff_prepare.work.def.stack_lifetime run data modify storage test: buff_prepare.work.res.policy set from storage test: buff_prepare.work.def.stack_lifetime
execute if data storage test: buff_prepare.work.def.interval run data modify storage test: buff_prepare.work.res.interval set from storage test: buff_prepare.work.def.interval
execute if data storage test: buff_prepare.work.def.timers run data modify storage test: buff_prepare.work.res.timers set from storage test: buff_prepare.work.def.timers
execute if data storage test: buff_prepare.work.def.params run data modify storage test: buff_prepare.work.res.params set from storage test: buff_prepare.work.def.params

data modify storage test: buff_prepare.result set from storage test: buff_prepare.work.res
data remove storage test: buff_prepare.work
return 1
