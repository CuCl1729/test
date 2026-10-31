#> test:crop/token/convert
# @s = プレイヤー。持ち物の作物の目印(custom_data.test.crop_token = 作物。育ちきった作物のルートテーブルが落とす)を、
# 作物ごとにバニラのアイテムに変える。test:cache/update が呼ぶ(釣りの目印 test:fish/token/convert と同じ考え方)。
# ホッパーなどで集めてチェストに入ったままの目印は変わらない(プレイヤーが拾ったときに変わる)

data modify storage test: crop_work.queue set from storage test: asset.crop_ids
function test:crop/token/convert_loop
