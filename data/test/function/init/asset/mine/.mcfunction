#> test:init/asset/mine/
# 鉱山と鉱脈のレジストリ(スプレッドシートの「鉱山」「鉱脈」タブから生成。中身は generated/mines・veins の見出しを参照)。
# 鉱山は場所(範囲・入口・リセット間隔)だけを持つ。鉱脈は種類(鉱石ブロック・原石・必要ランク・レア度の重み・形の構造物)で、
# どの鉱山にでも置ける。置くのは鉱脈のアマスタ(tag=mine_vein, data.vein。test:debug/spawn_vein)で、
# 鉱山の範囲の中にあるアマスタが、その鉱山のリセットで自分の位置に鉱脈を置き直す

data modify storage test: asset.mine set value {}
data modify storage test: asset.mine_ids set value []
data modify storage test: asset.vein set value {}
data modify storage test: asset.vein_ids set value []
function test:init/asset/mine/generated/mines
function test:init/asset/mine/generated/veins
