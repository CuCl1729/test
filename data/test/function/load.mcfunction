#> test:load
# 
# @private

function test:init/
function oh_my_dat:sys/load
# 職業のボーナス(成長・取得済みのパッシブ)を、今いる人の保存済みの状態から組み直す(シートの値の変更も反映する)
execute as @a run function test:job/refresh_bonus
