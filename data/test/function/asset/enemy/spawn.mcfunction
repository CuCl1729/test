#> test:asset/enemy/spawn
# @macro id: 敵のid。実行位置に、asset.enemy.<id> の定義どおりの敵を召喚する。定義が無ければ何もしない

$execute unless data storage test: asset.enemy.$(id) run return run function test:debug/log {msg:"敵「$(id)」の定義がありません"}

$function test:asset/enemy/load {id:"$(id)"}
function test:asset/enemy/summon {id:"armor_stand"}
