#> test:magic/beam/link/emit
# 実行位置・向き = 出来事を積む地点とその向き(光線の到達点)。link_work.meta を写してから捨てマーカーを出し、
# 座標・向きの確定と beam_events への積み込みは point 自身にやらせる(後続を起こすのは後で drain からの chain/start)
data remove storage test: link_work.event
data modify storage test: link_work.event set from storage test: link_work.meta

execute summon marker run function test:magic/beam/link/point
