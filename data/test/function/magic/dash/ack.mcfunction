#> test:magic/dash/ack
# @s = ダッシュ代理。test:magic/dash_ack エンチャントのminecraft:tick効果からだけ呼ばれる。
# ここではスコアを立てるだけ(data modify/mergeで@sのNBTを読み直すと、reload時に
# Motionが1軸あたり10を超える値で0へ戻されてしまう=impulseで動かした分が消えるため、NBTには触れない)。
scoreboard players set @s test.dash.ready 1
