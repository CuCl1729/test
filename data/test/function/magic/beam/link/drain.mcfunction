#> test:magic/beam/link/drain
# 確定した持続ビームが積んだ「後で始める段」の待ち行列を1件ずつ処理する。自動tickからは呼ばない(明示呼び出しのみ)
execute unless data storage test: beam_events[0] run return 0

data remove storage test: beam_event_work
data modify storage test: beam_event_work set from storage test: beam_events[0]
data remove storage test: beam_events[0]

function test:magic/beam/link/dispatch with storage test: beam_event_work

function test:magic/beam/link/drain
