#> test:debug/check_veins
# @s = プレイヤー。鉱山ごとに、test:action と test:turn の鉱脈のアマスタの位置と鉱脈のidを比べ、
# 片方にしか無いもの・同じ位置で鉱脈が違うものを一覧で出す(各行から [置く]/[消す]/[合わせる] で直せる)。
# 範囲は mine/place_veins と同じ選び方なので、リセットで置き直されるアマスタだけが対象。
# 読み込まれていない鉱山は調べられないので、[鉱山を読み込む] を出して飛ばす

tag @s add debug_vein_viewer
tellraw @s {text:"― 鉱脈のずれ(action ⇔ turn) ―",color:gold}
data modify storage test: debug_work.check_queue set from storage test: asset.mine_ids
function test:debug/check_veins_loop
tag @s remove debug_vein_viewer
