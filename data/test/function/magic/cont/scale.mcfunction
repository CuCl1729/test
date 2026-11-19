#> test:magic/cont/scale
# @s = この持続物の本体(プレイヤーのビームなら詠唱者、自動ビーム・場・自己持続ならその本体)。
# @macro period: パルス間隔(tick)
#
# 表示の数値は「1秒あたり」なので、1パルスぶんは period ÷ 20 倍。
# 割り切れないぶんは **本体ごとに** 持ち越すので、小さい値が毎パルス0に切り捨てられて消えない
# (例: 回復量1・間隔1tick なら、20回ぶんでちょうど1回ぶんの回復になる)。
# 持ち越しは本体の test.magic.frac.<種類> に置くため、別のビームや別の場の端数を借りることはない
$scoreboard players set #cont_period test.temporary $(period)

function test:magic/cont/scale_one {ch:"fire"}
function test:magic/cont/scale_one {ch:"water"}
function test:magic/cont/scale_one {ch:"wood"}
function test:magic/cont/scale_one {ch:"metal"}
function test:magic/cont/scale_one {ch:"earth"}

# 武器弾の物理ダメージは action_hit が武器のものを覚えている間だけ縮める(純粋な魔法は常に0のまま)
execute if data storage test: action_hit{kind:"weapon"} run function test:magic/cont/scale_one {ch:"physics"}

function test:magic/cont/scale_heal
