#> test:fish/token/convert
# @s = プレイヤー。持ち物の釣りの目印(custom_data.test.fish_token = 中身のid。釣りのルートテーブルが落とす)を、
# 中身ごとに素材に変える。test:cache/update が呼ぶ(鉱石の目印 test:mine/token/convert と同じ考え方)

data modify storage test: fish_work.queue set from storage test: asset.fish_pool_ids
function test:fish/token/convert_loop
