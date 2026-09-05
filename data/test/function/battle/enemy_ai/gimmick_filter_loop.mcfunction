#> test:battle/enemy_ai/gimmick_filter_loop
# enemy_ai_work.gimmick_queue(data.ai.gimmicksのコピー)を末尾から取り出し、
# 使用条件を満たすものだけ enemy_ai_work.candidates へ積む

execute unless data storage test: enemy_ai_work.gimmick_queue[-1] run return 0

data modify storage test: enemy_ai_work.gimmick_entry set from storage test: enemy_ai_work.gimmick_queue[-1]
data remove storage test: enemy_ai_work.gimmick_queue[-1]

function test:battle/enemy_ai/gimmick_check with storage test: enemy_ai_work.gimmick_entry

function test:battle/enemy_ai/gimmick_filter_loop
