#> test:job/reset/range_check
# @s = 確認待ちのプレイヤー。@macro station: ステーションのUUID

$execute if entity @e[tag=station,distance=..6,nbt={UUID:$(station)}] run return 0
function test:job/reset/clear
tellraw @s {text:"リセットを取り消した",color:"gray"}
