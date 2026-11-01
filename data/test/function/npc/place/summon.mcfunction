#> test:npc/place/summon
# 実行位置 = NPC の立つブロックの下の面の中心。@macro id/dim/kind/body: 見た目(マネキンか村人。tag=npc_body, npc.<id>)と、
# 右クリックを受け取るインタラクション(tag=npc_i, npc.<id>。見た目より少し大きくして、右クリックがこちらに当たるように)を出す。
# インタラクションの data.npc.def に定義を写す(変わったら test:npc/place/check が置き直す)。店員・銀行員は tag=npc_counter も付ける

$summon $(kind) ~ ~ ~ $(body)
$summon interaction ~ ~ ~ {width:0.9f,height:2.0f,response:1b,Tags:["npc_i","npc.$(id)","npc_new"],data:{npc:{id:"$(id)",dim:"$(dim)"}}}
$data modify entity @n[type=interaction,tag=npc_new] data.npc.def set from storage test: asset.npc.$(id)
$execute if data storage test: asset.npc.$(id){counter:1b} run tag @n[type=interaction,tag=npc_new] add npc_counter
tag @e[type=interaction,tag=npc_new] remove npc_new
