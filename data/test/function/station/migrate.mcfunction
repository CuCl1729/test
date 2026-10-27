#> test:station/migrate
# ステーションを統合する前に置いたマーカー(種類ごとのタグ)を、共通の形(タグ station + data.station)に直す。
# test:init/ と デバッグメニューから呼ぶ。直したものは次のtickに新しい名前で飾り直され、モードに入る
# (読み込まれていないチャンクのものは、近くで /reload すると直る)

execute as @e[tag=weapon_forge] run function test:station/migrate_one {old:"weapon_forge",id:"smithy",mode:0}
execute as @e[tag=equip_workshop] run function test:station/migrate_one {old:"equip_workshop",id:"smithy",mode:1}
execute as @e[tag=weapon_upgrade] run function test:station/migrate_one {old:"weapon_upgrade",id:"enhance",mode:0}
execute as @e[tag=equip_magic_station] run function test:station/migrate_one {old:"equip_magic_station",id:"enhance",mode:1}
execute as @e[tag=crafter] run function test:station/migrate_one {old:"crafter",id:"magic",mode:0}
execute as @e[tag=magic_research] run function test:station/migrate_one {old:"magic_research",id:"magic",mode:1}
execute as @e[tag=job_station] run function test:station/migrate_one {old:"job_station",id:"job",mode:0}
